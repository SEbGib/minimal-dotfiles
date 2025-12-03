# 🔐 Secure Secrets Management

Cette configuration dotfiles utilise **Bitwarden** pour la gestion sécurisée des données sensibles incluant les clés API, informations personnelles, et configurations serveur.

##   Pourquoi cette approche ?

-   **Sécurisé et fiable** - Bitwarden est un gestionnaire de mots de passe open-source reconnu
-   **Auto-hébergeable** - Vous pouvez héberger votre propre serveur Bitwarden
-   **Multi-plateforme** - Clients Bitwarden disponibles sur toutes les plateformes
-   **Chargement flexible** - Secrets chargés via la CLI Bitwarden
- 🔐 **Intégration transparente** - Fallback automatique si variables déjà définies

##   Comment ça fonctionne

Le système utilise la CLI Bitwarden pour récupérer les secrets. Le fichier `private_dot_env.tmpl` appelle la commande `bw` pour obtenir les secrets et les exporter comme variables d'environnement.

### Mécanisme de fallback
1. **Variables existantes** : Si une variable est déjà définie, elle est utilisée
2. **Bitwarden** : Sinon, tentative de récupération depuis Bitwarden
3. **Valeur vide** : Si Bitwarden n'est pas disponible, valeur vide

##   Prérequis

- **CLI Bitwarden** (installée automatiquement)
- **Compte Bitwarden** (gratuit ou premium)

##   Instructions d'installation

### 1. Installation automatique

La CLI Bitwarden s'installe automatiquement avec les dotfiles :

```bash
# Installation complète (inclut Bitwarden CLI)
chezmoi init --apply https://github.com/SEbGib/dotfiles.git
```

### 2. Configuration manuelle (si nécessaire)

```bash
# Installation manuelle de la CLI Bitwarden
./run_once_00-install-bitwarden-cli.sh.tmpl

# Ou installation complète des outils
chezmoi apply
```

### 3. Connexion à Bitwarden

```bash
# Connexion à votre compte
bw login

# Ou avec serveur personnalisé
bw config server https://votre-serveur-bitwarden.com
bw login
```

### 4. Synchronisation du coffre-fort

```bash
# Synchronisation des données
bw sync

# Vérification du statut
bw status
```

## 🗂️ Gestion des secrets

### Utilisation de la CLI Bitwarden

```bash
# Récupérer un secret (mot de passe)
bw get password <nom_item>

# Récupérer d'autres informations (notes, nom d'utilisateur)
bw get notes <nom_item>
bw get username <nom_item>

# Lister tous les items
bw list items

# Rechercher un item spécifique
bw get item <nom_item>
```

### 🔑 Secrets supportés

Le système charge automatiquement ces secrets depuis Bitwarden :

#### Développement
- `github_token` - Token GitHub pour git et CLI
- `openai_key` - Clé API OpenAI pour IA
- `notion_token` - Token Notion pour MCP
- `context7_key` - Clé Context7 pour documentation

#### Infrastructure  
- `personal_server` - Informations serveur personnel
- `backup_path` - Chemins de sauvegarde
- `ssh_keys` - Clés SSH privées

#### Configuration Git
- `git_user_name` - Nom utilisateur Git
- `git_user_email` - Email utilisateur Git
- `gpg_key_id` - ID clé GPG pour signatures

Assurez-vous d'avoir des items dans votre coffre-fort Bitwarden avec ces noms.

## 📝 Exemples d'utilisation

### Template automatique

Le fichier `private_dot_env.tmpl` charge automatiquement les secrets :

```bash
# Exemple pour GITHUB_TOKEN
{{- if (env "GITHUB_TOKEN") }}
export GITHUB_TOKEN="${GITHUB_TOKEN}"
{{- else }}
# Chargement depuis Bitwarden si disponible
{{- if lookPath "bw" }}
export GITHUB_TOKEN="$(bw get password github_token 2>/dev/null || echo '')"
{{- end }}
{{- end }}
```

### Gestion manuelle

```bash
# Tester la récupération d'un secret
bw get password github_token

# Appliquer la configuration avec les secrets
chezmoi apply

# Vérifier les variables d'environnement
env | grep -E "(GITHUB|NOTION|OPENAI)"
```

##   Bonnes pratiques de sécurité

### Organisation du coffre-fort

1. **Dossier dédié** : Créer un dossier "Dotfiles" dans Bitwarden
2. **Noms cohérents** : Utiliser les noms exacts attendus par les templates
3. **Descriptions claires** : Documenter l'usage de chaque secret
4. **Permissions** : Limiter l'accès aux secrets sensibles

### Rotation des tokens

```bash
# Rotation régulière recommandée (tous les 3-6 mois)
# 1. Générer nouveau token sur le service
# 2. Mettre à jour dans Bitwarden
# 3. Tester avec bw get password <token_name>
# 4. Appliquer avec chezmoi apply
# 5. Révoquer l'ancien token
```

### Sauvegardes

- **Export chiffré** : `bw export --format encrypted_json`
- **Stockage sécurisé** : Conserver les exports dans un lieu sûr
- **Test de restauration** : Vérifier régulièrement les sauvegardes
