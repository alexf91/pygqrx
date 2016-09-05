struct TagInfo
{
%TypeHeaderCode
#include <bookmarks.h>
%End

    TagInfo();
    TagInfo(QString name);
};


struct BookmarkInfo
{
%TypeHeaderCode
#include <bookmarks.h>
%End
    BookmarkInfo();
    bool operator<(const BookmarkInfo &other);
};


class Bookmarks : public QObject
{

%TypeHeaderCode
#include <bookmarks.h>
%End

public:
    // This is a Singleton Class now because you can not send qt-signals from static functions.
    static void create();
    static Bookmarks& Get();

    void add(BookmarkInfo& info);
    void remove(int index);
    bool load();
    bool save();
    int size();
    BookmarkInfo& getBookmark(int i);
    QList<BookmarkInfo> getBookmarksInRange(qint64 low, qint64 high);
    //int lowerBound(qint64 low);
    //int upperBound(qint64 high);

    QList<TagInfo> getTagList();
    TagInfo& findOrAddTag(QString tagName);
    int getTagIndex(QString tagName);
    bool removeTag(QString tagName);
    bool setTagChecked(QString tagName, bool bChecked);

    void setConfigDir(const QString&);

signals:
    void BookmarksChanged();
    void TagListChanged();

private:
    Bookmarks(); // Singleton Constructor is private.
};
