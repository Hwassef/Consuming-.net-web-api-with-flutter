using Microsoft.EntityFrameworkCore;
using P1;
using System;

namespace DAO
{
    public class ConnexionDB : DbContext
    {
        public ConnexionDB(DbContextOptions<ConnexionDB> options) : base(options)
        {
        }
        public DbSet<Livre> Livres { get; set; }
    }
}