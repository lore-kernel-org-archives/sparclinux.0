From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 16 May 2007 00:50:22 +0000
Subject: Re: slab hang on boot
Message-Id: <Pine.LNX.4.64.0705151748210.4272@schroedinger.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705142133190.17204@math>
 <20070514.151148.45744375.davem@davemloft.net>
 <Pine.LNX.4.64.0705141642350.13606@schroedinger.engr.sgi.com>
 <20070515163321.744e2388.akpm@linux-foundation.org>
 <Pine.LNX.4.64.0705151642530.3886@schroedinger.engr.sgi.com>
 <20070515165636.5057456e.akpm@linux-foundation.org>
In-Reply-To: <20070515165636.5057456e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mroos@linux.ee, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 May 2007, Andrew Morton wrote:

> Either that newly-added test isn't needed, or those ifdefs aren't needed?

The #ifdefs dont do the proper job thus the hack for Dave. The following 
RFC will clean things up.

http://marc.info/?l=linux-kernel&m7919444827939&w=2

