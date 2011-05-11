From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 11 May 2011 12:33:12 +0000
Subject: Re: [RFC/PATCH] sparc32/LEON: Cache flush during context switch
Message-Id: <4DCA8208.2030409@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DC89ECB.6030309@googlemail.com>
In-Reply-To: <4DC89ECB.6030309@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Daniel Hellstrom wrote:

>>
>>    Thus, we can simply replace the whole leon_flush_needed() function
>> body with "return 0;". However, this also destroys the cache information
>> printed at boot time. Therefore, I suggest to add an explicit
>> print_leon3_cache_config() function. This also has the advantage that we
>> can correct the wrong cache terminology by Gaisler. During the Leon 2
>> and 3 development, they mixed up the cache "set" and cache "way" terms.
>> The VHDL code as well as the manuals for these processors are full of
>> these errors, but apparently for Leon4 they got it right. Thumbs up.
>
>
> Please do not change this.

I was referring to the functionality of the leon_flush_needed() code, 
please improve comments and/or clean up code.

Daniel

