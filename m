From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 22 Mar 2004 00:35:48 +0000
Subject: Re: srmmu_nocache_calcsize with low memory
Message-Id: <20040322003548.GA4519@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040321155052.GA10374@spike>
In-Reply-To: <20040321155052.GA10374@spike>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Mar 21, 2004 at 07:44:46PM +0100, Stefan Holst wrote:

> i was currently using 64 pages, but didn't test with more than 3 processes
> or with high load. so 128 seems to be a good tradeoff for now.
> here's a small patch:

This needs to be tested extensively.  People with less than about
144MB of memory will have their pagetable area reduced in size, in
some cases by a lot.  I'm not going to apply this until I see some
favorable test results.

I'll try to do some testing myself, but people with smaller-memory
machines need to give this a spin on their workloads and provide
feedback.

-- 
Keith M Wesolowski
