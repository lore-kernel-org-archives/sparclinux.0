From: Chris Newport <crn@netunix.com>
Date: Thu, 29 Jun 2006 21:37:08 +0000
Subject: Re: booting the T1000
Message-Id: <44A44804.50001@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200606290937.49481.rene@exactcode.de>
In-Reply-To: <200606290937.49481.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:

>The default inetd package in Ubuntu, from iputils, is simply buggy,
>because it sets it's sockets to non-blocking and leaves that setting
>on the socket when it passes the connection on to the real application
>from inetd.  Applications expect the socket to be in blocking mode.
>As a result, tftpd craps out because it unexpectedly gets -EAGAIN on a
>read().
>
>To be honest this is a horrible selection of a default inetd
>implementation, netkit-inetd is probably what should be used instead.
>
>  
>
Is this really the root of the issue ?.
For about the last 5 years I have suffered similar issues with tftpd in 
Slackware, Solaris, and NetBSD, all of which use different inetd 
implementations.

Running tftpd standalone has always fixed it.

I could be wrong, but there seem to be generic issues running tftpd via 
inetd, often only intermittently reproduceable. 


