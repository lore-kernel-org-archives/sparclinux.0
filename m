From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 08:59:23 +0000
Subject: Re: [2/3] sun4d updates (guys, please send me real descriptions!)
Message-Id: <20041221085923.GI771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221042836.GZ771@holomorphy.com>
In-Reply-To: <20041221042836.GZ771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2004-12-20 20:28:36 -0800, William Lee Irwin III wrote:
>> -static void
>> +/* static */ void
>>  prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
>>  		   struct linux_prom_ranges *ranges2, int nranges2)
>>  {

On Tue, Dec 21, 2004 at 09:57:46AM +0100, Jan-Benedict Glaw wrote:
> I don't know this function (or where it is ment to be called from), but
> isn't this an example for __attribute__((unused)) ?

It's used in drivers/sbus/sbus.c; the commenting out of "static" should
probably die, and the thing should get declared in a header instead of
tripping a warning.


-- wli
