From: bert hubert <ahu@ds9a.nl>
Date: Sat, 05 Feb 2005 21:00:49 +0000
Subject: Re: SMP Ultra2 locks up in many cases, UP kernel works fine - 2.6.11-rc3-mm1
Message-Id: <20050205210049.GA27226@outpost.ds9a.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20050205194152.GB25413@outpost.ds9a.nl>
In-Reply-To: <20050205194152.GB25413@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Feb 05, 2005 at 08:41:52PM +0100, bert hubert wrote:

> 	- I'll put this log up on http://ds9a.nl/tmp/sun-bootlog when I've
> 	  captured it

Is up now, but the odd screenwiping phenomenon did not reappear. I have an
additional datapoint, which would be significant on i386 I think, not sure
if it matters on sparc: an SMP-capable kernel booted with 'maxcpus=1' works
fine, just as well as an UP kernel.

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
