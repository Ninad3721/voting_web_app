using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VotingApplication.Domain.Migrations
{
    /// <inheritdoc />
    public partial class AddedPartyTableChanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Name",
                table: "Parties",
                newName: "PartyName");

            migrationBuilder.AlterColumn<string>(
                name: "PartyName",
                table: "Candidates",
                type: "nvarchar(5)",
                maxLength: 5,
                nullable: false,
                oldClrType: typeof(long),
                oldType: "bigint");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "PartyName",
                table: "Parties",
                newName: "Name");

            migrationBuilder.AlterColumn<long>(
                name: "PartyName",
                table: "Candidates",
                type: "bigint",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(5)",
                oldMaxLength: 5);
        }
    }
}