From: David Miller <davem@davemloft.net>
Date: Sat, 13 Sep 2008 01:02:17 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20080912.180217.50789700.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <elahav@uwaterloo.ca>
Date: Fri, 12 Sep 2008 20:53:11 -0400

> > This is what other ports do.
> 
> Here's the information from my dual-core athlon processor. Again, the format is CPUID proc_id core_id (sibling mask) (core mask):
> 
> CPUID  proc_id  core_id  sibling_mask  core_mask
> 00     00       00       (00)          (00,01)
> 01     00       01       (01)          (00,01)
> 
> As you can see, the processor ID refers to a single package (with ID 0), and the core ID is different for each CPU, as expected.

Niagara T1 is a single "package", with 8 "cores".

Look at a dump from a multi-socket Niagara T2 system.
