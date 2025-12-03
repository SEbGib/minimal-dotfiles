# Zen Browser Transparency Configuration

Ce répertoire contient la configuration pour activer la transparence dans Zen Browser.

## Fichiers inclus

- `user.js` - Configuration des préférences Firefox requises pour la transparence
- `userChrome.css` - Styles CSS pour améliorer l'apparence transparente
- `README.md` - Documentation complète

## Installation automatique

La configuration est appliquée automatiquement via le script `run_once_11-setup-zen-transparency.sh.tmpl` qui s'exécute après l'installation de Zen Browser.

## Configuration manuelle

Si vous souhaitez configurer manuellement la transparence :

### 1. Prérequis (about:config)

Ouvrez Zen Browser et allez dans `about:config`. Assurez-vous que ces paramètres sont définis sur `true` :

```
browser.tabs.allow_transparent_browser = true
zen.theme.gradient.show-custom-colors = true
```

Pour Linux (si applicable) :
```
zen.widget.linux.transparency = true
```

### 2. Extension Transparent Zen

Installez l'extension [Transparent Zen](https://addons.mozilla.org/en-US/firefox/addon/transparent-zen) depuis le Firefox Add-Ons Store ou manuellement depuis [GitHub](https://github.com/frostybiscuit/transparent-zen).

### 3. Couleur du thème

Clic droit sur la barre d'outils > **Changer les couleurs du thème**  
Utilisez le code hexadécimal `#00000066` pour un fond légèrement foncé tout en maintenant la lisibilité.

### 4. Configuration avancée (optionnel)

Le fichier `userChrome.css` contient des styles supplémentaires pour :

- Supprimer le fond lumineux derrière la zone de rendu du site
- Rendre les onglets transparents
- Rendre la barre d'outils transparente avec effet de flou

## Compatibilité

- **Windows 11** : Nécessite `widget.transparent-windows` et `widget.windows.mica` à `true`
- **Linux** : Nécessite `zen.widget.linux.transparency` à `true` et effets de flou système pour KDE Plasma
- **macOS** : Configuration standard avec les paramètres de base

## Dépannage

- Si la transparence ne fonctionne pas, vérifiez que tous les paramètres `about:config` sont bien activés
- Assurez-vous que l'extension Transparent Zen est correctement installée
- Sur Linux, vérifiez que les effets de transparence système sont activés
- Si vous utilisez Dark Reader, désactivez-le pour les sites que vous voulez rendre transparents