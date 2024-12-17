import os
import subprocess

def get_file_commits(file_path):
    """Récupère la liste des commits affectant un fichier spécifique."""
    result = subprocess.run(
        ["git", "log", "--reverse", "--pretty=format:%H", "--", file_path],
        stdout=subprocess.PIPE,
        text=True
    )
    commits = result.stdout.splitlines()
    return commits

def get_commit_message(commit_hash):
    """Récupère le message d'un commit donné."""
    result = subprocess.run(
        ["git", "log", "--format=%B", "-n", "1", commit_hash],
        stdout=subprocess.PIPE,
        text=True
    )
    return result.stdout.strip()

def increment_version(version, version_type):
    """Incrémente la version en fonction du type (minor ou patch)."""
    major, minor, patch = map(int, version.split("."))
    if version_type == "minor":
        minor += 1
        patch = 0
    elif version_type == "patch":
        patch += 1
    return f"{major}.{minor}.{patch}"

def calculate_version(file_path):
    """Calcule la version finale d'un fichier en fonction de son historique."""
    commits = get_file_commits(file_path)
    if not commits:
        print(f"Aucun commit trouvé pour le fichier {file_path}.")
        return "1.0.0"
    version = "1.0.0"
    for commit_hash in commits:
        commit_message = get_commit_message(commit_hash)
        if commit_message.startswith("feat:"):
            version = increment_version(version, "minor")
        else:
            version = increment_version(version, "patch")
    return version

def update_file_version(file_path, version):
    """Met à jour la ligne # @version et supprime # Version dans le fichier."""
    with open(file_path, "r+") as f:
        lines = f.readlines()
        updated = False
        cleaned_lines = []
        for line in lines:
            if line.startswith("# @version"):
                line = f"# @version {version}\n"
                updated = True
                print(f"Version du fichier {file_path} mise à jour vers {version}.")
                continue
            elif line.strip().startswith("shdoc_version ="):
                line = f'    shdoc_version = "{version}"\n'
                updated = True
                print(f"shdoc_version du fichier {file_path} mise à jour vers {version}.")
            cleaned_lines.append(line)
        if not updated:
            print(f"Aucune ligne '# @version' trouvée dans le fichier {file_path}. Aucun changement effectué.")
        f.seek(0)
        f.writelines(cleaned_lines)
        f.truncate()

def process_directory(directory, file_condition):
    """Parcours un répertoire et traite les fichiers répondant à une condition."""
    if not os.path.isdir(directory):
        print(f"Le répertoire {directory} n'existe pas.")
        return
    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            if file_condition(file):
                print(f"Traitement du fichier : {file_path}")
                final_version = calculate_version(file_path)
                print(f"Version calculée pour {file_path} : {final_version}")
                update_file_version(file_path, final_version)

def main():
    """Point d'entrée principal."""
    process_directory(
        "./",
        lambda file: file.endswith("shdoc")
    )

if __name__ == "__main__":
    main()
