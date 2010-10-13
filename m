From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 13 Oct 2010 18:33:00 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on
Message-Id: <19637.64348.72182.502916@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
	<19624.63312.156073.410319@pilspetsen.it.uu.se>
	<20101012.144039.245407019.davem@davemloft.net>
In-Reply-To: <20101012.144039.245407019.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > 
 > BTW, and this is a long shot, but in another thread someone
 > reported that the following patch causes sporadic problems
 > for them.
 > 
 > Can you try reverting it from the current tree and seeing if
 > that makes the hangs go away?
 > 
 > Thanks!
 > 
 > commit 6dda9d55bf545013597724bf0cd79d01bd2bd944
 > Author: Corrado Zoccolo <czoccolo@gmail.com>
 > Date:   Mon May 24 14:31:54 2010 -0700
 > 
 >     page allocator: reduce fragmentation in buddy allocator by adding buddies that are merging to the tail of the free lists

I'll test -rc7 with this one reverted tomorrow.
