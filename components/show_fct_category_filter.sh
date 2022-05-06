#!/usr/bin/env bash

# As these fct scan the bashlava.sh file, it was seaching for itself causing display issues.
# That why we run these fct under this file.

function Show_Fct_Category_Filter {
  my_message="${_fct_name}" && Print_Blue && echo
  my_message="$(cat ${_file_path} | grep "${_filter}" | awk '{print $2}')" && Print_Gray && echo
}

# These pass attributs to 'Show_Fct_Category_Filter'
Show_Fct_Category_Condition() { _fct_name="2) Condition" _filter="function Condition_" _file_path="${_path_bashlava}/bashlava.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_Core() { _fct_name="3) Core" _filter="function Core_" _file_path="${_path_bashlava}/bashlava.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_Example() { _fct_name="4) Example" _filter="function ex_" _file_path="${_path_components}/example.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_Print() { _fct_name="5) Print" _filter="function Print_" _file_path="${_path_bashlava}/bashlava.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_Show() { _fct_name="6) Show" _filter="function Show_" _file_path="${_path_bashlava}/bashlava.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_User() { _fct_name="7) User" _filter="# User_" _file_path="${_path_bashlava}/bashlava.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_Utility() { _fct_name="8) Utility" _filter="function Utility_" _file_path="${_path_components}/utilities.sh" && Show_Fct_Category_Filter ; }
Show_Fct_Category_F1() { my_message="Function f1 does not exist yet." && Print_Gray && echo ; }
Show_Fct_Category_F2() { my_message="Function f2 does not exist yet." && Print_Gray && echo ; }

function Show_Fct_Category_All {
  arr=( "Alias" "Condition" "Core" "Example" "Print" "Show" "User" "Utility" )
  for action in "${arr[@]}"; do
    Show_Fct_Category_"${action}" && sleep 0.2
  done
}

# Function in alias are very different so I can't reuse 'Show_Fct_Category_Filter'
function Show_Fct_Category_Alias {
  my_message="1) Alias" && Print_Blue && echo
  my_message="$(cat ${_path_components}/alias.sh | grep "()" | awk '{print $1}' | sed 's/()//g')" && Print_Gray && echo
}
