{
  # todo comments
  plugins.todo-comments = {
    enable = true;
  };

  # discord rich presence
  plugins.neocord = {
    enable = true;
    lazyLoad.settings.event = ["VeryLazy"];
    settings = {
      logo = "auto";
      main_image = "logo";
      show_time = true;
    };
  };
}
