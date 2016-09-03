class CMeter : public QFrame
{

%TypeHeaderCode
#include <meter.h>
%End

public:
    explicit CMeter(QWidget *parent /TransferThis/ = 0);
    //explicit CMeter(float min_level, float max_level, QWidget *parent /TransferThis/ = 0);
    ~CMeter();

    QSize minimumSizeHint() const;
    QSize sizeHint() const;

    //void setMin(float min_level);
    //void setMax(float max_level);
    //void setRange(float min_level, float max_level);

    void draw();
    void UpdateOverlay();

signals:

public slots:
    void setLevel(float dbfs);

protected:
    //re-implemented widget event handlers
    void paintEvent(QPaintEvent *event);
    void resizeEvent(QResizeEvent* event);

private:
    void DrawOverlay();
};
