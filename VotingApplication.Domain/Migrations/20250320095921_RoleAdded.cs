using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VotingApplication.Domain.Migrations
{
    /// <inheritdoc />
    public partial class RoleAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Role",
                table: "Voters",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "Voter");

            migrationBuilder.AddColumn<string>(
                name: "Role",
                table: "Candidates",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "Candidate");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Role",
                table: "Voters");

            migrationBuilder.DropColumn(
                name: "Role",
                table: "Candidates");
        }
    }
}