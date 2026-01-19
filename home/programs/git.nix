{
  enable = true;
  signing = {
    signByDefault = true;
    key = "A96D0830396F4327";
  };
  settings = {
    core.pager = "delta";
    interactive.diffFilter = "delta --color-only";
    delta = {
      line-numbers = true;
      navigate = true;
      dark = true;
    };
    merge.conflictStyle = "zdiff3";
    user = {
      name = "2kybe3";
      email = "kybe@kybe.xyz";
    };
    init.defaultBranch = "main";
  };
}
