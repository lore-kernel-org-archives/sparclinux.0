From: David Miller <davem@davemloft.net>
Date: Wed, 02 Jul 2008 04:45:07 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <20080701.214507.261426026.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
	<20080625.150931.182895076.davem@davemloft.net>
	<Pine.LNX.4.64.0807020032510.19403@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807020032510.19403@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: helge.hafting@aitel.hist.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 2 Jul 2008 00:39:35 -0400 (EDT)

> The ABI is very vague about it. The V9 ABI just displays that 6-word space 
> in a figure bug doesn't say anything about it's usage. The V8 ABI just 
> says that "the function may write incoming arguments there". If it may 
> write anything other, it is unknown --- probably yes, but it is not said 
> in the document.
> 
> The document nicely specifies who owns which registers, but doesn't say 
> that about the stack space :-(

Actually, I know for a fact that you have to have those slots there.

A long time ago in the sparc64 kernel, in the trap entry code, I tried
only giving 128 bytes of stack frame as the trap entry called into C
code.  And it did not work, I had to put the 6 slots there.
