From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 15 Jan 2012 14:09:39 +0000
Subject: silo fails to build with recent ext2fs libraries
Message-Id: <20120115140938.GA7564@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Recently I've discovered that silo fails to build with recent ext2fs 
libraries. Debian bug report [0] shows the relevant part of the build 
log. Someone also reported the same problem on gentoo forum just a few 
days ago [1].

As far as I can understand, the problem arises because newer ext2fs 
library versions introduced additional symbols, depending on libc 
functions not implemented in silo, into the same object files which 
contain the symbols used by the second stage. Since linker operates on 
object file level, it pulls in these symbols along with needed ones, 
then fails to resolve their dependencies because they are not 
implemented in silo and we are not linking against libc.

I was hoping that I can create a reduced ext2fs library containing 
only necessary symbols, but later recognized that this would require 
compiling and maintaining an explicit list of such symbols and their 
dependencies, which would be pretty tedious and error prone. I've also 
tried pruning the symbols causing the failure from the original 
library, however it's not possible in some cases, as some of them are 
mentioned in relocation entries. Another option would be to start 
linking against libc to work around this problem, but I don't know why 
it was not done in the first place, some size constraints perhaps?

[0] http://bugs.debian.org/655897
[1] http://forums.gentoo.org/viewtopic-p-6923830.html?sidtbeb3b8188dd2e6f33a39b6503479c4

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
