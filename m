From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 05 Sep 2018 16:01:52 +0000
Subject: Re: [PATCH 3/3] of: make default address and size cells sizes private
Message-Id: <b508d80f-71a9-c34a-bbb2-c0ced3f6f399@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180830190523.31474-1-robh@kernel.org>
 <20180830190523.31474-4-robh@kernel.org>
 <35247ddc-303b-89d0-53b5-231c1a293721@gmail.com>
 <9c873e57-84c8-75af-1d44-60e7cd41282d@ilande.co.uk>
 <CAL_JsqJ5qZpdA2QugzEg8dJSyddZkK3ABfJO4RG0-bbM4kaWaw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ5qZpdA2QugzEg8dJSyddZkK3ABfJO4RG0-bbM4kaWaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On 05/09/18 13:12, Rob Herring wrote:

> On Tue, Sep 4, 2018 at 11:59 PM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 05/09/18 02:55, Frank Rowand wrote:
>>
>>> On 08/30/18 12:05, Rob Herring wrote:
>>>> Only some old OpenFirmware implementations rely on default sizes. Any
>>>> FDT and modern implementation should have explicit properties. Make the
>>>> OF_ROOT_NODE_*_CELLS_DEFAULT defines private so we don't get any outside
>>>> users.
>>>>
>>>> This also gets us one step closer to removing the asm/prom.h dependency on
>>>> Sparc.
>>
>> Just for the record: you say "any FDT and modern implementation should
>> have explicit properties", however the default values of these
>> properties when missing are clearly defined in the IEEE-1275
>> specification (Annex A):
> 
> The spec may define defaults, but best practice is to be explicit. For
> FDT, dtc doesn't allow defaults (and never has). No arch added in the
> last 10 years has relied on the defaults.
> 
>> "#address-cells"
>> Standard property name to define the package’s address format.
>> ...
>> In a package with a "decode-unit" method, a missing "#address-cells"
>> property signifies that the number of
>> address cells is two.
> 
> So only Sparc is compliant as the default for everyone else is 1.
> 
>> "#size-cells"
>> Standard property name to define the package’s address size format.
>> ...
>> A missing "#size-cells" property signifies the default value of one.
>>
>> I can't speak for FDT but it isn't completely unreasonable for a guest
>> parsing a DT without these properties to assume these default values.
> 
> I'm not removing the defaults. Just not allowing for code outside of
> drivers/of/ to use the defaults.

Got it - if dtc requires explicit properties, then I agree there should
be no issues with this patch. Sorry for the noise.


ATB,

Mark.
