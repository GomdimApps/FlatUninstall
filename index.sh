#!/bin/bash

while true; do
  
  app_ids=($(flatpak list --app --columns=application))
  app_names=($(flatpak list --app --columns=name))
  app_versions=($(flatpak list --app --columns=version))

  menu_lines=()

  for i in "${!app_ids[@]}"; do
    menu_lines+=("${app_ids[$i]} - ${app_names[$i]} - Versão: ${app_versions[$i]}")
  done

  app_id=$(zenity --list --title="Desinstalar Apps Flatpak" --cancel-label="Sair" --ok-label="Desinstalar" --column="Aplicativos" "${menu_lines[@]}")

  if [ -n "$app_id" ]; then
  
    app_id=$(echo "$app_id" | cut -d' ' -f1)

   
    if zenity --question --text="Você tem certeza de que deseja desinstalar $app_id?" --ok-label="Sim" --cancel-label="Não"; then
    
      pkexec flatpak uninstall -y "$app_id"
    fi
  else
   
    break
  fi
done
