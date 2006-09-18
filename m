From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2006 07:38:23 +0000
Subject: Re: Possible bug in sys_getdomainname() on sparc64
Message-Id: <20060918.003823.15263874.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <43513.192.168.1.10.1157439907.squirrel@otter.puszczka.com>
In-Reply-To: <43513.192.168.1.10.1157439907.squirrel@otter.puszczka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Also, arch/sparc/kernel/sys_sparc.c has the same error and thus
needs the exact same fix.  It would be appreciated if you would
fix both cases in your updated patch.

Thanks.
