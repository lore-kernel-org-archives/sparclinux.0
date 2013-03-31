From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:31:00 +0000
Subject: Re: [PATCH] sparc:remove unused declaration smp_boot_cpus()
Message-Id: <20130331.193100.1277516238806990183.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5152E41D.2030901@huawei.com>
	<20130329110904.GA2765@merkur.ravnborg.org>
In-Reply-To: <20130329110904.GA2765@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: wangkefeng.wang@huawei.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 29 Mar 2013 12:09:04 +0100

> On Wed, Mar 27, 2013 at 08:20:45PM +0800, Kefeng Wang wrote:
>> smp_boot_cpus() was replaced smp_prepare_cpus() long ago, and it no
>> longer needed, so delete it.
>> 
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
