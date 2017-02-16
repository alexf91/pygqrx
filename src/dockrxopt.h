#ifndef DOCKRXOPT_H
#define DOCKRXOPT_H

#include <QString>

/*
 * This class exists only to allow building all other source
 * files directly from the repository
 */
class DockRxOpt
{
public:
    static bool IsModulationValid(QString strModulation)
    {
        (void) strModulation;
        return true;
    }
};

#endif /* DOCKRXOPT_H */
