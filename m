From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 27 Feb 2005 19:43:25 +0000
Subject: Re: DBRI fixes and improvements [2.4]
Message-Id: <422222DD.2050604@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <421FA83B.2050901@wp.pl>
In-Reply-To: <421FA83B.2050901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> 
> Feel free to do a 2.6.x sound layer port of this driver if you
> wish :-)  It's the only SBUS audio driver that no port attempt
> was done for.
> 

DBRI audio needs more work - playback is not fully working (e.g. 8-bit 
modes, no stereo in A-law, u-law). Recording is even worse - I haven't 
tested but I see many empty functions.  There is also space for 
improvements (e.g. replace modulo and division operators with mask and 
shifting in simple cases).

I think that fixing the driver first (at least playback) is better then 
port it with fixes rather than porting now then prepare two patches for 
every fix (for 2.4 and 2.6). I don't know much about ALSA architecture 
either. But I may try with if time allows.

Krzysztof

