From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 15 Sep 2017 01:30:28 +0000
Subject: Re: [PATCH v8 10/11] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <c76f72fc-21ed-62d0-014e-8509c0374f96@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170914223517.8242-1-pasha.tatashin@oracle.com>
 <20170914223517.8242-11-pasha.tatashin@oracle.com>
 <20170915011035.GA6936@remoulade>
In-Reply-To: <20170915011035.GA6936@remoulade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Mark,

Thank you for looking at this. We can't do this because page table is 
not set until cpu_replace_ttbr1() is called. So, we can't do memset() on 
this memory until then.

Pasha

