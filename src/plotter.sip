class CPlotter : public QFrame
{
%TypeHeaderCode
#include <plotter.h>
%End

public:
    explicit CPlotter(QWidget *parent /TransferThis/ = 0);
    ~CPlotter();

    QSize minimumSizeHint() const;
    QSize sizeHint() const;

    //void SetSdrInterface(CSdrInterface* ptr){m_pSdrInterface = ptr;}
    void draw();		//call to draw new fft data onto screen plot
    void setRunningState(bool running);
    void setClickResolution(int clickres);
    void setFilterClickResolution(int clickres);
    void setFilterBoxEnabled(bool enabled);
    void setCenterLineEnabled(bool enabled);
    void setTooltipsEnabled(bool enabled);
    void setPercent2DScreen(int percent);

    void setNewFttData(float *fftData, int size);
    //void setNewFttData(float *fftData, float *wfData, int size);

    void setCenterFreq(quint64 f);
    void setFreqUnits(qint32 unit);

    void setDemodCenterFreq(quint64 f);

    /*! \brief Move the filter to freq_hz from center. */
    void setFilterOffset(qint64 freq_hz);
    qint64 getFilterOffset();
    int getFilterBw();
    void setHiLowCutFrequencies(int LowCut, int HiCut);

    void setDemodRanges(int FLowCmin, int FLowCmax, int FHiCmin, int FHiCmax, bool symetric);

    /* Shown bandwidth around SetCenterFreq() */
    void setSpanFreq(quint32 s);

    void setMinMaxDB(float min, float max);
    void setHdivDelta(int delta);
    void setVdivDelta(int delta);

    void setFreqDigits(int digits);

    /* Determines full bandwidth. */
    void setSampleRate(float rate);
    float getSampleRate();
    void setFftCenterFreq(qint64 f);

    int     getNearestPeak(QPoint pt);
    void    setWaterfallSpan(quint64 span_ms);
    quint64 getWfTimeRes();
    void    setFftRate(int rate_hz);
    void    clearWaterfall();
    bool    saveWaterfall(const QString & filename) const;

signals:
    void newCenterFreq(qint64 f);
    void newDemodFreq(qint64 freq, qint64 delta); /* delta is the offset from the center */
    void newLowCutFreq(int f);
    void newHighCutFreq(int f);
    void newFilterFreq(int low, int high);  /* substitute for NewLow / NewHigh */
    void fftRangeChanged(float reflevel, float range);

public slots:
    // zoom functions
    void resetHorizontalZoom();
    void moveToCenterFreq();
    void moveToDemodFreq();
    void zoomOnXAxis(float level);

    // other FFT slots
    void setFftPlotColor(const QColor color);
    void setFftFill(bool enabled);
    void setPeakHold(bool enabled);
    void setFftRange(float reflevel, float range);
    void setPeakDetection(bool enabled, float c);
    void updateOverlay();

protected:
    //re-implemented widget event handlers
    void paintEvent(QPaintEvent *event);
    void resizeEvent(QResizeEvent* event);
    void mouseMoveEvent(QMouseEvent * event);
    void mousePressEvent(QMouseEvent * event);
    void mouseReleaseEvent(QMouseEvent * event);
    void wheelEvent( QWheelEvent * event );
};

