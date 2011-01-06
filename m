From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 06 Jan 2011 09:27:48 +0000
Subject: Re: [PATCH] cassini: Use local-mac-address prom property for Cassini
Message-Id: <4D258B14.5080407@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1294273030.6193.31.camel@duncow>
In-Reply-To: <1294273030.6193.31.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On 06/01/2011 00:39, Julian Calaby wrote:
> On Thu, Jan 6, 2011 at 11:17, Richard Mortimer<richm@oldelvet.org.uk>  wrote:
>> Fallback on the local-mac-address prom property if the Cassini device
>> does not have an address programmed in the VPD ROM. This uses the same
>> technique as implemented by the sungem driver.
>
> Should this possibly depend on CONFIG_OF instead of CONFIG_SPARC?
>

Hi Julian,

Thanks for the tip. I'll cook a version up using CONFIG_OF later today.

Regards

Richard

> Thanks,
>
