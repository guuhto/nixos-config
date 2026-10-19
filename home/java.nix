{ pkgs, ... }:
{
  # Java padrão do sistema (ATM10 e uso geral)
  home.packages = [ pkgs.jdk21 ];

  # Caminhos fixos para o Prism escolher por instância
  home.file.".jdks/jdk17".source = pkgs.jdk17;
  home.file.".jdks/jdk21".source = pkgs.jdk21;
  home.file.".jdks/jdk25".source = pkgs.jdk25;
}
