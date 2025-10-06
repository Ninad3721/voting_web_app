using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VotingApplication.Domain.Migrations
{
    /// <inheritdoc />
    public partial class PasswordAndRoleAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "Voters",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Password",
                table: "Candidates",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Password",
                table: "Voters");

            migrationBuilder.DropColumn(
                name: "Password",
                table: "Candidates");
        }
    }
}