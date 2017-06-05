From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 05 Jun 2017 20:10:04 +0000
Subject: Re: [v1 5/6] sparc64: new context wrap
Message-Id: <0fce5547-556b-8866-b6c6-055e43732c22@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496244325-180257-6-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496244325-180257-6-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Ok, thanks for the details.
> 
> I'm not too happy about scanning NCPUS 'mm' pointers every context
> wrap, that can be up to 4096 so the cost is not exactly trivial.

Hi Dave,

Thank you for accepting the changes.

Going through NCPU proportional loop for xcall purpose or 'mm' pointers 
is a fundamental limitation when there is only one global context 
counter per system. To solve this limitation would be a different 
project: we will need multiple context counters per system: up-to one 
per core. Bob Picco is working on adding this support. In that case the 
loop sizes are going to be bound by:
NCPU / (# context domains)

Pasha
