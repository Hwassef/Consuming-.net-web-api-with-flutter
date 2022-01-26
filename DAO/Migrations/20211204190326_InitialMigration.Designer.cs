﻿// <auto-generated />
using DAO;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace DAO.Migrations
{
    [DbContext(typeof(ConnexionDB))]
    [Migration("20211204190326_InitialMigration")]
    partial class InitialMigration
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 64)
                .HasAnnotation("ProductVersion", "5.0.12");

            modelBuilder.Entity("P1.Livre", b =>
                {
                    b.Property<int>("id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("auteur")
                        .HasColumnType("longtext");

                    b.Property<int>("nbExemplaire")
                        .HasColumnType("int");

                    b.Property<double>("prix")
                        .HasColumnType("double");

                    b.Property<string>("titre")
                        .HasColumnType("longtext");

                    b.HasKey("id");

                    b.ToTable("Livres");
                });
#pragma warning restore 612, 618
        }
    }
}
