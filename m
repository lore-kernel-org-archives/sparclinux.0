From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Mon, 07 Mar 2005 17:12:41 +0000
Subject: Re: Proll updates
Message-Id: <BAY12-F10F494872DA292A7186972FF5F0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F905F574458EF2DA963E0BFF5E0@phx.gbl>
In-Reply-To: <BAY12-F905F574458EF2DA963E0BFF5E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>Where do they come from, I wonder? What part of your distro produces them?
>My RHL did not print any escape sequences for colored "[ok]" on serial
>console.

Linux prints the escape sequences at boot when console=prom. Proll prints 
the text to graphical console (TCX, black text on white bg). Later, when 
Linux switches to the tcxfb console, the garbage gets cleared and text is 
grey on black. On a serial console, probably your terminal emulator handles 
the escape codes.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

