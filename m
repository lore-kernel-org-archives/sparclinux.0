From: David Miller <davem@davemloft.net>
Date: Tue, 10 Oct 2006 21:44:48 +0000
Subject: Re: [PATCH 4/4] fix sparc32 modpost warnings
Message-Id: <20061010.144448.27784011.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154635.GE30909@palantir8>
In-Reply-To: <20061010154635.GE30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 16:46:35 +0100

> Fix this 2.6.19-rc1 build warnings from modpost:
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text:sunzilog_console_setup from .data between 'sunzilog_console' (at offset 0x8394) and 'devices_subsys'
>
>Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
 ...
> -static struct console sunzilog_console = {
> +static struct console sunzilog_console_ops = {

I'll apply this, but why does simply changing the symbol
name make the section conflict go away?
