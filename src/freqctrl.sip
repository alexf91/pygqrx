class CFreqCtrl : public QFrame
{

%TypeHeaderCode
#include <freqctrl.h>
%End

public:
    enum FUNITS
    {
        UNITS_HZ,
        UNITS_KHZ,
        UNITS_MHZ,
        UNITS_GHZ,
        UNITS_SEC,
        UNITS_MSEC,
        UNITS_USEC,
        UNITS_NSEC
    };

    explicit CFreqCtrl(QWidget *parent /TransferThis/ = 0);
    ~CFreqCtrl();
    QSize minimumSizeHint() const;
    QSize sizeHint() const;

    //primary access routines
    void setup(int NumDigits, qint64 Minf, qint64 Maxf,int MinStep, FUNITS UnitsType);
    void setUnits(FUNITS units);
    void setDigitColor(QColor cr);
    void setBkColor(QColor cr);
    void setUnitsColor(QColor cr);
    void setHighlightColor(QColor cr);
    qint64 getFrequency();
    void setResetLowerDigits(bool reset);

signals:
    void newFrequency(qint64 freq); //emitted when frequency has changed

public slots:
    void setFrequency(qint64 freq);

protected:      //overrides for this control
    void paintEvent(QPaintEvent *);
    void resizeEvent(QResizeEvent *);
    void mouseMoveEvent(QMouseEvent *);
    void mousePressEvent(QMouseEvent *);
    void wheelEvent(QWheelEvent *);
    void leaveEvent(QEvent *);
    void keyPressEvent(QKeyEvent *);

};
