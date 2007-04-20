From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Fri, 20 Apr 2007 22:55:37 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <0b7b01c7839f$02cb11d0$84163e05@kroptech.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
>>> From: "Adam Kropelin" <akropel1@rochester.rr.com>
>>>> Starting smartd: esp: esp0: Aborting command [fffff80030b05280:2a]
>>>> esp: esp0: Active command [fffff80030b05280:2a]
>>>> esp: esp0: Aborting command [fffff80030b05280:00]
>>>> esp: esp0: Queued command [fffff80030b05280:00]
>>>> esp: esp0: Aborting command [fffff80030b05280:00]
>>>> esp: esp0: Queued command [fffff80030b05280:00]
> Ok I think I nailed this.
>
> I converted the ESP driver over to using auto-requestsense
> when CHECK_CONDITION occurs for a scsi command.
>
> The new ESP driver now passes my dbench+smartd-loop stress
> test.

Works here, too. I have run dry of issues to report: the new driver is 
working flawlessly.

Thanks!
--Adam

