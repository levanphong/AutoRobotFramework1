 # delete all screenshot in folder
    for file in results/screenshots/*; do
      if [[ -d $file ]]; then
          rm $file
        else
          rm -f $file
          fi
    done

    # delete all reports in folder
    for file in results/reports/*; do
      if [[ -d $file ]]; then
          rm $file
        else
          rm -f $file
          fi
    done

    # delete pabot sub result in folder
    for file in results/pabot_results/*/*; do
      if [[ -d $file ]]; then
          rm $file
        else
          rm -r $file
          fi
    done

    # delete pabot result in folder
    for file in results/*; do
      if [[ -d $file ]]; then
          rm $file
        else
          rm -r $file
          fi
    done
