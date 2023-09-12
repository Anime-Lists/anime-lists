Anime Lists
===========

Anime mapping lists used by:
  - [AniDB.net [MOD] scrapers](https://forum.kodi.tv/showthread.php?tid=142835) for [Kodi](https://kodi.tv/)
  - [HTTP Anidb Metadata Agent (HAMA)](https://github.com/ZeroQI/Hama.bundle) for [Plex](https://plex.tv)
  - [Plex Meta Manager](https://github.com/meisnate12/Plex-Meta-Manager)
  - [MyAnimeList Plex Metadata Agent](https://github.com/Fribb/MyAnimeList.bundle)
  - [Ani-Sync Jellyfin Plugin](https://github.com/vosmiic/jellyfin-ani-sync) for [Jellyfin](https://jellyfin.org/)
  - [JellySeer](https://github.com/Fallenbagel/jellyseerr)
  - [Overseer](https://github.com/sct/overseerr)
  
These lists map information between [AniDB](https://anidb.net), [TheTVDB](https://www.thetvdb.com), [TMDB](https://www.themoviedb.org) and [IMDB](https://www.imdb.com).

The Lists
---------

### anime-movieset-list.xml ###
This list contains groupings of anime titles that are suitable as movie sets (includes movies, TV specials, and one-shot OVAs).

### anime-list-master.xml ###
This list contains entries for every title on AniDB.net and serves as a template from which all the remaining lists are derived.
Feel free to [contribute to it](#contributing) if you notice missing or mismatched entries

### anime-list.xml ###
The default list used by the scraper.  Contains all entries from the master list that are not empty or marked as "unknown".

### anime-list-full.xml ###
Alternative list for the scraper.  Contains all entries from the master list that are not empty (but includes "unknown" titles).

### anime-list-unknown.xml ###
Maintenance list containing all entries that are marked as "unknown".
Any of these titles may potentially become "known" if they are added to TheTVDB.com or TheMovieDB.org.

### anime-list-todo.xml ###
All empty entries from the master list.  Literally a to-do list.

### animetitles.xml ###
Copy of the animetitles.xml available from AniDB.net.  This is used by the scraper to search for matching titles.

Format
------

### anime-list-master.xml ###

A typical entry in anime-list-master.xml:

    <anime anidbid="23" tvdbid="76885" defaulttvdbseason="1" episodeoffset="" tmdbid="" imdbid="">
      <name>Cowboy Bebop</name>
      <mapping-list>
        <mapping anidbseason="0" tvdbseason="0">;1-2;</mapping>
      </mapping-list>
      <supplemental-info>
        <studio>Sunrise</studio>
      </supplemental-info>
    </anime>

Each entry consists of an **anime** node with the following attributes:

*   **anidbid** - The AniDB.net id (pre-filled).

*   **tvdbid** - TheTVDB.com **series** id (do not use movie IDs). Multi-episode titles not found on TheTVDB.com are marked as "unknown", as they may eventually get added and
    this makes it easier to re-check (via anime-list-unknown.xml).  One-off titles that won't ever be added to TheTVDB.com (movies, TV specials, one-shot OVAs)
    are marked by their AniDB.net type, unless they can be associated to a multi-episode series (in which case they use the corresponding TheTVDB.com id or "unknown").

    Pornographic titles are marked by "hentai" regardless of episode count as they will never appear on TheTVDB.com.

*   **defaulttvdbseason** - The corresponding TheTVDB.com season.
    For one-off titles it will be `1` unless associated to a multi-episode series, in which case it will be `0`.
    Series that span multiple seasons on TheTVDB.com may be marked as `a` if the absolute episode numbering is defined and matches AniDB.net.

*   **episodeoffset** - Number to add to each regular AniDB.net episode number to get the corresponding TheTVDB.com episode number in the defaulttvdbseason.
    Not necessary if the episode numbers match up exactly.
    For special episodes and more complex situations the mapping-list is used (see below).

*   **tmdbid**/**imdbid** - TheMovieDB.org/imdb.com ID. Only used for standalone entries like movies.
    Multiple IDs can be mapped to the same AniDB entry with comma sepparation. Ex: `tmdbid="12345,67890"`, `imdbid="tt12345678,tt9876543"`
    **[Do not use tmdbid for series!](https://github.com/ScudLee/anime-lists/issues/342)**

Within the anime node are any of the following nodes

*   **name** - Title taken from the "main" listing in the animetitles.xml (pre-filled).

*   **mapping-list** - Used to map individual episodes between AniDB.net and TheTVDB.com (see below).
    Not necessary if episode numbers match up exactly within the season(s).

*   **before** - Used to position special episodes within the regular episodes.
    This information is usually supplied by TheTVDB.com for the scraper,
    and is only included in the mapping list if there is a disparity
    (such as when AniDB.net special episodes correspond to TheTVDB.com regular episodes).

    Format is: ` ;1-5;2-6;...; ` where the first number in each mapping is the AniDB.net special episode number
    and the second is the AniDB.net regular episode it should be listed before.
    Episodes to be forced to the end of the series are mapped to their intended higher episode numbers.

*   **supplemental-info** - Extra information that is not supplied by the AniDB.net (see below).
    To be used sparingly.

#### mapping-list ####
The mapping-list node consists of one or more **mapping** nodes with the following attributes:

*   **anidbseason** - The AniDB.net season (either `1` for regular episodes or `0` for specials).

*   **tvdbseason** - The corresponding TheTVDB.com season.

*   **start** - The first AniDB.net episode the offset applies to.

*   **end** - The last AniDB.net episode the offset applies to.

*  **offset**  - The number to add to each AniDB.net episode between the start and end values.

    The format for mapping individual episodes is: ` ;1-5;2-6;...; ` where the first number in each mapping is the AniDB.net episode number
    and the second is the corresponding TheTVDB.com episode number for the season specified.
    For a single AniDB.net episode to multiple TheTVDB.com episodes, you can link the latter with `+`. For example ` ;1-1+2; ` if the AniDB.net episode 1 contains both TheTVDB.com episodes 1 and 2.
    Conversely, multiple AniDB.net episodes simply map to the same TheTVDB.com episode. For example ` ;1-1;2-1; ` if AniDB.net episodes 1 and 2 are parts of TheTVDB.com episode 1. (**` ;1+2-1; ` IS NOT VALID!**)
    
    AniDB trailer episodes with prefix T can be mapped by using episode numbers >= 201, T1 = 201. "Other" episodes can be mapped using episode numbers >= 401, O1 = 401.

    The start, end, and offset attributes are not necessary if only individual episodes are being mapped.
    The offset and/or episodeoffset will be ignored in favour of an individual mapping.

    Episodes on AniDB.net that don't match anything on TheTVDB.com are mapped to 0 if and only if there's a conflict.

#### supplemental-info ####
The supplemental-info node may contain an optional attribute of **replace="true"**, in which case the information will replace that supplied by AniDB.net, otherwise it is just added to (and prioritised over) the AniDB.net information.

Any of the following nodes are allowed multiple times in a supplemental-info node:

*   **studio** - The animation studio.  This need only be included if no "Animation Work" or "Work" is supplied in the Main Staff box on AniDB.net.

*   **genre**

*   **actor**

*   **director**

*   **credits** - (i.e. Writer).

*   **thumb** - URL of a thumbnail to use instead of the AniDB.net one.  Needs to include an attribute of either **aspect="poster"** or **aspect="banner"**.

*   **fanart** - Fanart to use instead of TheTVDB.com or TheMovieDB.org ones.  Can only be one fanart node, but it can contain multiple **thumb** nodes (see below).

The fanart node consists of **thumb** nodes that contain the URL of the fanart to use.

Each fanart thumb node has the following attributes:

*   **dim** - Dimensions of the fanart. e.g. ` 1280x720 `.

*   **colors** - e.g. ` |148,149,153|13,23,22|165,159,137| ` (...Usually left blank.)

*   **preview** - URL to a smaller preview copy of the thumb.

### anime-movieset-list.xml ###
A typical entry in anime-movieset-list.xml:

    <set>
      <anime anidbid="61">Koukaku Kidoutai</anime>
      <anime anidbid="890">Innocence</anime>
      <anime anidbid="6122">Koukaku Kidoutai 2.0</anime>
      <titles>
        <title type="main" xml:lang="x-jat">Koukaku Kidoutai Collection</title>
        <title type="official" xml:lang="en">Ghost in the Shell Collection</title>
      </titles>
    </set>

Each entry consists of a **set** node containing two or more **anime** nodes, and a single **titles** node that in turn contains one or more **title** nodes.

Each **anime** node consists of an **anidbid** attribute that corresponds to the AniDB.net id, and contains the "main" title (as taken from the animetitles.xml).

Each **title** node consists of two attributes, either **type="main" xml:lang="x-jat"** or **type="official" xml:lang="xx"** where **xx** is one of `en`, `de`, `fr`, `it`, `cs`, `sk`, `hu`, `pl`, `ru`, `ja`, `zh` (these are the only languages settable in the scraper).

The "main" title is always present and is derived from an appropriate "main" (romaji) title on AniDB.net, while the "official" titles are derived from the corresponding "official" titles in the relevant languages.  Unofficial translations are not used.

Contributing
------------
There are a couple of ways to contribute updates:

The simplest way is to just open an [Issue](https://github.com/Anime-Lists/anime-lists/issues), and they will be dealt with when noticed.

The prefered way is to open a [Pull Request](https://github.com/Anime-Lists/anime-lists/pulls):

1.   [Fork the repo](https://github.com/Anime-Lists/anime-lists/fork)
2.   Create a new branch (`git checkout -b new_branch`)
3.   Edit **anime-list-master.xml** and/or **anime-movieset-list.xml** following the [Format](/#format)
4.   Commit your changes (`git commit -am "Added some titles"`)
5.   Push to the branch (`git push origin new_branch`)
6.   [Submit the Pull Request](https://github.com/Anime-Lists/anime-lists/compare)
7.   Wait for review/merge
8.   Profit

**Do not edit any other lists!!!** They are automatically generated after your Pull Request was merged.

Likewise, the anime names and the sort order in `anime-movieset-list.xml` will be automatically fixed based on the **anidbid**s, so don't be overly concerned about getting them exactly right (but obviously do get the **title** nodes right).


Batch Files
-----------
Used to automate update and generation of the lists.
<details>
 <summary>(click to expand)</summary>
DO NOT run any of these when contributing!

The Windows batch files are used to automate the updating of the lists.
They require the following programs to work:
*   **[curl.exe](http://curl.haxx.se/)** - Used to download animetitles.xml from AniDB.net.
*   **[xsltproc.exe](https://github.com/CoppeliaRobotics/xsltproc-win/blob/master/xsltproc-win.zip?raw=true)** - Used to apply the xsl transformations to the lists.
*   **git** - Used to automatically commit the update of animetitles.xml.

curl and xsltproc (and dependencies) should either be in the folder or added somewhere in the Windows PATH.

### update.bat ###
Downloads the latest animetitles.xml, sorts it, updates anime-list-master.xml, and calls generate-lists.bat.

### update.sh ###
Same as `update.bat` but for POSIX platforms.

### generate-lists.bat ###
Generates all the other lists based on anime-list-master.xml, and updates/sorts anime-movieset-list.xml.

### generate-lists.sh ###
Same as `generate-lists.bat` but for POSIX platforms. As most POSIX style systems already have xsl and xml tools installed, this is just a shell script to generate the xml files.

### generate-lists.groovy ###
Same as `generate-lists.bat` but for all platforms. It requires [Groovy](http://www.groovy-lang.org/) and [Java](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and works on Windows, Linux and Mac OS X.
</details>
