From: David Miller <davem@davemloft.net>
Date: Thu, 06 Oct 2011 05:49:27 +0000
Subject: Re: [PATCH 4/4] kernel,debug: SPARC KGDB stub strcpy fix
Message-Id: <20111006.014927.705420810859307897.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1317390450-5982-5-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317390450-5982-5-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 30 Sep 2011 15:47:30 +0200

> Works aroung the fact that strcpy in SPARC returns 0.
> 
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>

Fix strcpy() on SPARC instead please.
