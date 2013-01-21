From: David Miller <davem@davemloft.net>
Date: Mon, 21 Jan 2013 22:34:34 +0000
Subject: Re: [PATCH v3] sparc: kernel/sbus.c: fix memory leakage
Message-Id: <20130121.173434.1226195006313740040.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <50F7EED3.1050309@oldelvet.org.uk>
	<20130117132843.GD25615@gmail.com>
	<50FDBF34.4020409@oldelvet.org.uk>
In-Reply-To: <50FDBF34.4020409@oldelvet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: richm@oldelvet.org.uk
Cc: dinggnu@gmail.com, sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 21 Jan 2013 22:20:36 +0000

> Reviewed-by: Richard Mortimer <richm@oldelvet.org.uk>
> 
> On 17/01/2013 13:28, Cong Ding wrote:
>> The variable iommu and strbuf are not freed properly if it goes to
>> error.
>>
>> Signed-off-by: Cong Ding <dinggnu@gmail.com>

Applied, thanks everyone.
