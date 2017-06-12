From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 20:02:54 +0000
Subject: Re: [v2 4/8] sparc64: optimize loads in clock_sched()
Message-Id: <043dd4df-c3f8-7e07-68c8-9bf433eac323@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Perhaps get rid of the __read_mostly.

OK, or as alternative we could do something like:

__read_mostly __aligned(SMP_CACHE_BYTES)

Not sure what is better though.

Pasha
