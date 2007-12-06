From: Wes Hardin <wes.hardin@dalsemi.com>
Date: Thu, 06 Dec 2007 18:15:21 +0000
Subject: Re: SunOS/Solaris Binary Emulation
Message-Id: <47583C39.8050906@dalsemi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <475825D7.1090209@dalsemi.com>
In-Reply-To: <475825D7.1090209@dalsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

assuming I'm reading the output of readelf correctly, the only shared library 
mentioned is libc.so.1

manhack:/usr/gnemul/solaris# readelf -d bin/uname

Dynamic section at offset 0x14b8 contains 22 entries:
   Tag        Type                         Name/Value
  0x00000001 (NEEDED)                     Shared library: [libc.so.1]

which is already copied over.

manhack:/usr/gnemul/solaris# ls lib/libc.so.1
lib/libc.so.1

Checksums match:

manhack:/usr/gnemul/solaris# cksum lib/libc.so.1
1414919188 1158072 lib/libc.so.1

whardin@cds3 / $ cksum /lib/libc.so.1
1414919188 1158072 /lib/libc.so.1

--
/* wes hardin */


Jan Engelhardt wrote:
> On Dec 6 2007 10:39, Wes Hardin wrote:
>> manhack:/usr/gnemul/solaris/bin# file ./uname
>> ./uname: ELF 32-bit MSB executable, SPARC, version 1 (SYSV), dynamically linked
>> (uses shared libs), stripped
>> manhack:/usr/gnemul/solaris/bin# ./uname
>> -bash: ./uname: No such file or directory
>>
>> I don't know if the Linux ldd is supposed to work on these binaries, but it
>> doesn't:
>>
>> manhack:/usr/gnemul/solaris/bin# ldd ./uname
>> /usr/bin/ldd: line 117: ./uname: No such file or directory
> 
> I suppose you need the Solaris libraries too, including dynamic
> linker. See output of `readelf -d uname`.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
