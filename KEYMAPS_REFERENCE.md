# Référence Rapide - Keymaps Neovim & Tmux

##   Nouveaux Keymaps Treesitter

### Sélection de Code (Text Objects)

| Keymap | Description | Exemple d'usage |
|--------|-------------|-----------------|
| `af` | Fonction complète (outer) | `daf` - Supprimer fonction |
| `if` | Contenu fonction (inner) | `vif` - Sélectionner corps |
| `ac` | Classe complète (outer) | `yac` - Copier classe |
| `ic` | Contenu classe (inner) | `vic` - Sélectionner corps classe |
| `aa` | Paramètre avec virgule (outer) | `daa` - Supprimer paramètre |
| `ia` | Paramètre seul (inner) | `cia` - Changer paramètre |
| `aC` | Commentaire | `daC` - Supprimer commentaire |

**  Combiner avec opérateurs Vim:**
- `d` (delete) + text object = Supprimer
- `y` (yank) + text object = Copier
- `c` (change) + text object = Changer
- `v` (visual) + text object = Sélectionner

### Navigation Rapide

| Keymap | Description |
|--------|-------------|
| `]f` | Aller au début de la fonction suivante |
| `[f` | Aller au début de la fonction précédente |
| `]F` | Aller à la fin de la fonction suivante |
| `[F` | Aller à la fin de la fonction précédente |
| `]c` | Aller au début de la classe suivante |
| `[c` | Aller au début de la classe précédente |
| `]C` | Aller à la fin de la classe suivante |
| `[C` | Aller à la fin de la classe précédente |

### Sélection Incrémentale

| Keymap | Mode | Description |
|--------|------|-------------|
| `<CR>` | Visuel | Étendre la sélection au nœud suivant |
| `<S-CR>` | Visuel | Étendre au scope englobant |
| `<BS>` | Visuel | Réduire la sélection |

**  Workflow sélection progressive:**
1. Positionner curseur sur un mot
2. `v` pour entrer en mode visuel
3. `<CR>` plusieurs fois pour étendre
4. `<BS>` si trop étendu

---

##   Keymaps Existants (Rappel)

### Leader Key
`<leader>` = `Espace`

### Édition de Base

| Keymap | Mode | Description |
|--------|------|-------------|
| `jk` | Insert | Sortir du mode insertion |
| `<leader>nh` | Normal | Clear search highlights |
| `J` | Visuel | Déplacer ligne vers le bas |
| `K` | Visuel | Déplacer ligne vers le haut |
| `<` | Visuel | Indenter à gauche (reste en visuel) |
| `>` | Visuel | Indenter à droite (reste en visuel) |

### Fenêtres (Windows)

| Keymap | Description |
|--------|-------------|
| `<leader>-` | Split vertical |
| `<leader>_` | Split horizontal |
| `<leader>se` | Égaliser tailles |
| `<leader>sx` | Fermer split courant |

### Onglets (Tabs)

| Keymap | Description |
|--------|-------------|
| `<leader>to` | Nouvel onglet |
| `<leader>tx` | Fermer onglet |
| `<leader>tn` | Onglet suivant |
| `<leader>tp` | Onglet précédent |

### FZF-Lua (Recherche)

| Keymap | Description |
|--------|-------------|
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep (recherche texte) |
| `<leader>fb` | Find Buffers |
| `<leader>fh` | Help Tags |
| `<leader>fr` | Recent Files |
| `<leader>fc` | Commands |

### Git avec FZF

| Keymap | Description |
|--------|-------------|
| `<leader>gf` | Git Files |
| `<leader>gb` | Git Branches |
| `<leader>gl` | Git Log |
| `<leader>gs` | Git Status |
| `<leader>ga` | Git Add All |
| `<leader>gc` | Git Commit |
| `<leader>gp` | Git Push |

### LSP

| Keymap | Description |
|--------|-------------|
| `<leader>lr` | LSP References |
| `<leader>ld` | LSP Definitions |
| `<leader>ls` | Document Symbols |
| `<leader>lw` | Workspace Symbols |

### Symfony

| Keymap | Description |
|--------|-------------|
| `<leader>sc` | Symfony Console |
| `<leader>ss` | Symfony Serve |
| `<leader>st` | Load Fixtures |
| `<leader>sm` | Symfony Make... |

### PHP

| Keymap | Description |
|--------|-------------|
| `<leader>pa` | PHP Artisan |
| `<leader>pc` | Composer |

### Claude Code

| Keymap | Description |
|--------|-------------|
| `<leader>ac` | Toggle Claude |
| `<leader>as` | Send to Claude |
| `<leader>ad` | Accept Diff |
| `<leader>ar` | Reject Diff |

### Colorizer

| Keymap | Description |
|--------|-------------|
| `<leader>ct` | Toggle Colorizer |

---

## 🎨 Tmux Keymaps

### Général

| Keymap | Description |
|--------|-------------|
| `<prefix> + r` | Recharger config |
| `<prefix> + n` | Nouvelle session |
| `<prefix> + f` | Fuzzy finder sessions |
| `<prefix> + o` | Sessionx (gestionnaire sessions) |
| `<prefix> + M` | Menu tmux |

**Note**: `<prefix>` = `Ctrl+b`

### Splits/Panes

| Keymap | Description |
|--------|-------------|
| `<prefix> + -` | Split vertical (côte à côte) |
| `<prefix> + _` | Split horizontal (haut/bas) |
| `<prefix> + m` | Maximiser pane (toggle) |
| `<prefix> + h/j/k/l` | Redimensionner pane |
| `<prefix> + H/J/K/L` | Sélectionner pane (AZERTY) |
| `<prefix> + ↑/↓/←/→` | Sélectionner pane (flèches) |

### Navigation Vim-tmux

| Keymap | Description |
|--------|-------------|
| `Ctrl+h` | Aller à gauche (Vim + tmux) |
| `Ctrl+j` | Aller en bas (Vim + tmux) |
| `Ctrl+k` | Aller en haut (Vim + tmux) |
| `Ctrl+l` | Aller à droite (Vim + tmux) |

**  Pas de prefix nécessaire, navigation fluide entre Vim et tmux!**

### Copy Mode

| Keymap | Description |
|--------|-------------|
| `<prefix> + v` | Entrer en copy-mode |
| `v` | Début sélection (dans copy-mode) |
| `y` | Copier sélection |
| `Enter` | Copier et quitter |

### Popups Outils Dev

| Keymap | Description |
|--------|-------------|
| `<prefix> + g` | Lazygit popup |
| `<prefix> + @` | Lazydocker popup |
| `<prefix> + B` | Rainfrog (database) popup |
| `<prefix> + T` | Menu outils développement |

**Menu outils (`<prefix> + T`):**
- `g` - Lazygit (répertoire courant)
- `@` - Lazydocker
- `B` - Rainfrog (database)
- `h` - htop
- `r` - ranger (file browser)

### Sessions Work Machine

| Keymap | Description |
|--------|-------------|
| `<prefix> + W` | Nouvelle fenêtre dev (nvim) |
| `<prefix> + S` | Nouvelle fenêtre shell |
| `<prefix> + L` | Nouvelle fenêtre logs |

**Note**: Disponible uniquement sur machine work

---

##   Workflows Combinés

### Workflow 1: Refactoring de Fonction
```
1. ]f              # Aller à la fonction
2. vaf             # Sélectionner toute la fonction
3. y               # Copier
4. :tabnew         # Nouveau fichier
5. p               # Coller
6. cif             # Changer le contenu
```

### Workflow 2: Navigation + Git
```
1. <leader>ff      # Trouver fichier
2. ]c              # Aller à première classe
3. vac             # Sélectionner classe
4. <leader>gs      # Git status
5. <prefix> + g    # Lazygit popup pour commit
```

### Workflow 3: Database Inspection
```
1. <prefix> + B    # Ouvrir Rainfrog
2. (dans Rainfrog)
3. Alt+5           # Accéder aux favoris
4. ↑↓              # Naviguer
5. Enter           # Exécuter requête
```

### Workflow 4: Multi-Fichiers
```
1. <prefix> + -    # Split vertical
2. Ctrl+h/l        # Naviguer entre splits
3. <leader>ff      # Chercher fichier (split 1)
4. Ctrl+l          # Aller au split 2
5. <leader>fg      # Live grep (split 2)
6. [f / ]f         # Naviguer entre fonctions
```

### Workflow 5: Édition Complète
```
1. v               # Mode visuel
2. <CR>            # Étendre sélection
3. <CR>            # Étendre encore
4. c               # Changer
5. (éditer)
6. <Esc>
7. daf             # Supprimer fonction suivante
8. ]f              # Aller à prochaine
```

---

##   Astuces Pro

### Treesitter
- **Combiner avec opérateurs**: `daf`, `yif`, `cic`, `vaa`
- **Utiliser en visual-line**: `Vaf` sélectionne ligne par ligne
- **Dot repeat**: `.` répète la dernière action text object

### Tmux
- **Zoom temporaire**: `<prefix> + m` puis refaire pour dézoom
- **Copy multi-panes**: Copy mode + sélection traverse les panes
- **Rename session**: `<prefix> + $`

### FZF
- **Preview toggle**: `Ctrl+/` dans FZF
- **Multi-select**: `Tab` dans FZF
- **Scroll preview**: `Ctrl+u/d` dans FZF

### Vim General
- **Repeat**: `.` répète dernière commande
- **Undo tree**: `u` (undo), `Ctrl+r` (redo)
- **Marks**: `ma` (marquer), `'a` (revenir)

---

##   Ressources

### Documentation Locale
- Analyse complète: `~/.config/nvim/ANALYSIS_AND_IMPROVEMENTS.md`
- Changelog: `~/projects/dotfiles/CHANGELOG_OPTIMIZATIONS.md`
- Rainfrog: `~/.config/rainfrog/QUICK_START.md`

### Aide Intégrée
```vim
:help treesitter-textobjects
:help treesitter
:WhichKey <leader>     " Voir tous les keymaps leader
```

### Tmux
```bash
<prefix> + ?           # Liste tous les keybindings
```

---

**Dernière mise à jour**: 2025-10-15
**Version**: Phase 1 & 2 complétées
