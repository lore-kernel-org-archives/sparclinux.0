From: David Miller <davem@davemloft.net>
Date: Thu, 03 Oct 2013 00:12:33 +0000
Subject: Re: [PATCH] sparc: remove deprecated IRQF_DISABLED
Message-Id: <20131002.201233.1096442405039316943.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1378539489-7607-1-git-send-email-michael.opdenacker@free-electrons.com>
In-Reply-To: <1378539489-7607-1-git-send-email-michael.opdenacker@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael.opdenacker@free-electrons.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Date: Sat,  7 Sep 2013 09:38:09 +0200

> This patch proposes to remove the IRQF_DISABLED flag from sparc architecture
> code. It's a NOOP since 2.6.35 and it will be removed one day.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Applied.
