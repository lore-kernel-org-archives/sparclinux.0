From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 06 Jan 2011 00:39:34 +0000
Subject: Re: [PATCH] cassini: Use local-mac-address prom property for Cassini
Message-Id: <AANLkTik+5ydNh++AUvx0QJ-Gxjqeuc1_um3bxCRp3z+9@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294273030.6193.31.camel@duncow>
In-Reply-To: <1294273030.6193.31.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 6, 2011 at 11:17, Richard Mortimer <richm@oldelvet.org.uk> wrote:
> Fallback on the local-mac-address prom property if the Cassini device
> does not have an address programmed in the VPD ROM. This uses the same
> technique as implemented by the sungem driver.

Should this possibly depend on CONFIG_OF instead of CONFIG_SPARC?

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
