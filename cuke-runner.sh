function usage {
  echo "Various cucumber commands:"
  echo ""
  echo "1. xdg-open ~/Documents/the-cucumber-book_b5_0.pdf"
  echo "      This command opens the cucumber book (Beta 5)"
  echo ""
  echo "2. cucumber"
  echo "      Base cucumber command"
  echo ""
  echo "3. cucumber --dry-run"
  echo "      Display undefined steps"
  echo ""
  echo "4. cucumber --tags ~@cucumber_example"
  echo "      Run all cucumber tests, except for the cucumber examples"
  echo ""
  echo "5. cucumber features/kfsi_bugs/KFSI-1021.feature -r features"
  echo "      Run a specific feature file"
}

if [[ $1 = "" ]]; then
  usage
  exit 1
fi

case $1 in
1)
  xdg-open ~/Documents/the-cucumber-book_b5_0.pdf
  ;;
2)
  cucumber
  ;;
3)
  cucumber --dry-run
  ;;
4)
  cucumber --tags ~@cucumber_example
  ;;
5)
  cucumber features/kfsi_bugs/KFSI-$2.feature -r features
  ;;
*)
  usage
  exit 1
  ;;
esac