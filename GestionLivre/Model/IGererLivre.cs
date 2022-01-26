using P1;
using System.Collections.Generic;

namespace GestionLivre.Model
{
    public interface IGererLivre
    {
        List<Livre> getLivres();
        double CalculerValuerBib();
        bool deleteLivreById(int id);
        bool addLivre(Livre l);
        bool updateLivre(Livre newL);

    }
}