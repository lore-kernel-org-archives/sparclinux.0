From: Michael Witten <mfwitten@gmail.com>
Date: Fri, 25 Sep 2020 20:20:20 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Message-Id: <859f327c79da4d9c945e50568805456c@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
  <20200914.170321.1710628974878239639.davem@davemloft.net>
In-Reply-To: <20200914.170321.1710628974878239639.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 14 Sep 2020 17:03:21 -0700

> From: Michael Witten <mfwitten@gmail.com>
> Date: Fri, 04 Sep 2020 19:40:00 -0000
>
>> @@ -34,10 +34,10 @@ EXPORT_SYMBOL(of_console_options);
>>  int of_getintprop_default(struct device_node *np, const char *name, int def)
>>  {
>>       struct property *prop;
>> -     int len;
>> +     int size;
>> 
>> -     prop = of_find_property(np, name, &len);
>> -     if (!prop || len != 4)
>> +     prop = of_find_property(np, name, &size);
>> +     if (!prop || size != 4)
>>               return def;
>
> This is just changing the variable name and makes no functional change
> at all, and therefore is gratuitous.
>
> Please only include pure functional changes that fix the bug(s) in
> question.
>
> [...]

There's a reason the variable is named "size" (or even "len") rather than:

  v75127e6344

A name is functional; it is the only way we have to structure a [human]
reader's conceptual understanding of what's going on.

The name "len" is a poor choice; it added to my uncertainty when I began
trying to understand the code in question.

As explained in the commit message:

  | String Size
  | =====  |
  | There is an important distinction to be made between the following:
  |
  |   * A nul-terminated string's size
  |   * A nul-terminated string's length
  |
  | This commit tries to make this distinction as much as possible,
  | and assumes that all strings are intended to be nul-terminated.
  | The result is the following:
  |
  |   * Sometimes a variable's name is simply changed (e.g., from
  |     'len' to 'size').
  |
  |   * Sometimes 'strlen()' is called rather than relying on
  |     some buffer size.
  |
  |   * Sometimes, there is the replacement of code that erroneously
  |     uses string length rather than string size.
  |
  | All together, these changes make the code more robust and correct.

Are we trying to improve the code or not?

Also, this name change is like a surgeon removing a benign anomaly
while the abdomen is open for some other purpose; it's strategic,
not "gratuitous".

Sincerely,
Michael Witten
