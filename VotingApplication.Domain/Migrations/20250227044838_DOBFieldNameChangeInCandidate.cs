using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VotingApplication.Domain.Migrations
{
    /// <inheritdoc />
    public partial class DOBFieldNameChangeInCandidate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Dob",
                table: "Candidates",
                newName: "DOB");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "DOB",
                table: "Candidates",
                newName: "Dob");
        }
    }
}