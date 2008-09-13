From: Elad Lahav <elahav@uwaterloo.ca>
Date: Sat, 13 Sep 2008 00:53:11 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <48CB0EF7.3070102@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> This is what other ports do.

Here's the information from my dual-core athlon processor. Again, the 
format is CPUID proc_id core_id (sibling mask) (core mask):

CPUID  proc_id  core_id  sibling_mask  core_mask
00     00       00       (00)          (00,01)
01     00       01       (01)          (00,01)

As you can see, the processor ID refers to a single package (with ID 0), 
and the core ID is different for each CPU, as expected.

Elad
