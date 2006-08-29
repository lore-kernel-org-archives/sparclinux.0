From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 29 Aug 2006 20:59:50 +0000
Subject: Sparc termios.h
Message-Id: <1156885191.6271.133.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Can someone explain to me the somewhat strange termios structure stuff
going on in both sparc32 and sparc64. I'm adding c_ispeed/c_ospeed to
termios and updating ports/adding new ioctls when neccessary but I'm not
clear what the sparc folks are trying to achieve.

Alan
                
        
