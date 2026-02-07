Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6D3A1DB;
	Sat,  7 Feb 2026 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770430431; cv=none; b=IGXoF0s5kdzDGqNCN8LFKEOz86l2Q8Gxd0oudNAfPHLOYQLOy3zwcSLxMf+tj2VZYi/hr3sW5Bhm6q/9YQQFeFEJGcxZbulAy94N7GwTGpLbG4wLt613wqXVNYqYc7mWDKTJnO7IRiqYzAC7FijeIsNI/V28Tyskn3gPkBI5y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770430431; c=relaxed/simple;
	bh=HrGrb3HFWMp1C+Qi7I+EMMHWu/6VUR1lb1RExuTfmCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dv0cUmRjxMMM8skOlwiFxyy6rgXZCsmB0yCysAKZ6q6l73O4rdJo35j4OTbjGf55jOcp09pLV6+bjtQqktIGnyap37UFfN/lvwUTSO8V+lIaRg5tsqYf9HUCo4zgc78usATqVimb658aMqyTuTz5k6V1Zgi1MJalCk0PELttcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=iGFFRo/Y; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="iGFFRo/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1770430398; x=1771035198; i=deller@gmx.de;
	bh=EAlJH2wdGLPJvpxRE2kPJnzarDPa5Sy3AlVNuwC9Hl8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iGFFRo/Y59M3TZztFppsVEDMJfarLe4HqZWmOcPg8/ZD6w153S9G8HdS3amh2ZW5
	 hsuzmqVpzqoAY9iQFaS7qDfugkFFT4YyRfHBsfc5u0/hX0Pbyu4AhWR3P6j69G4yw
	 u7PPVzgTukAlGb16/nmj1jYk61nWIBTY6ABjr4mw52GdLJaC+0rnI88MXqhp5WdQU
	 i1+n9NTaYoNjYwUdyXtl2baYHUipTOetzY+UUPRI6YvRzAzD5zEtqNBzIgqmKzIGs
	 ohMdQWMdXYcjR9iYxvGpJzZenvJCLt0pF7QPnJkTlmqZTj6zRz0SMrwtzMLLuFJ8R
	 fwy7hO9RnjLlz/N7Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.105]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1w6kOO0FGo-00SaWY; Sat, 07
 Feb 2026 03:13:18 +0100
Message-ID: <aa9f72af-55b8-471f-afd2-5fc7f2328ba3@gmx.de>
Date: Sat, 7 Feb 2026 03:13:14 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20260124095628.668870-1-rppt@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260124095628.668870-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckJ9uICnC2KzZfMGScbkszoe3tJwid4EQMcHnKznQaIeHVj3lHk
 qEWVv45ooVrZf6199cKjQ2UmjQ1rTQ5GCIFqDFI/cBIKZm80I/jl8rSgthy5cMlQKPshHCe
 wABC6qDRcrsFfS+JPelc82LDtGJ4jgKaL1tZBup+OSqgzB/1iY0VBf2qQwt4HUEq8N1kLRl
 UfiVpP6RtvApG+R5VLKnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qul66nSOCXc=;4mo2hvNiceQrWi27PrLmcGklCpf
 /dpSzezdxjJp92g9c9bKzRyuVD5XMfB/SbhmqGEgcWMRwcJEssbFplkADdfzvQqEnEZV2VerB
 So6k0L1RShapJAm5YdEv0fU6i6dCB1TGL3E7OyxpKAeqHRSAYxzd6tiuKADJUzDIf59t4A4WQ
 Qx7H/wXDYT00ypDDuMcOgUdXCZYlnxisvPoy5OzlU+IExsbFCO4Wo+Ixeq/B2G1gfJE1A9ZDt
 Gpm0aAU1yAgtMaR6qhQTeQoCwQQ1WxhO8J5IYKQCER2cBGnweQkY042flDw6OPHnfE31c41pD
 a27VqYn32PBJGHQZtNjGasnU3rMJDfjYwdLQvlOM/rxPJdqpKZVbX9mBQrJV5RJ4Mea4q6MwX
 eNFOjy14qYy8J7Q6RVk1ZIiQEZISjJnn200CiYcbNOyUHAT2PvS0MYmzlUD8GiSq+fC/czr7S
 +9OMRvbHEJ6Gea1UMuVx8O6o7qQxdnD2rnQci/y7DM+kbjJO7Ag67dR26l6zdWI3YwhIk4Mrz
 GWMTSaIm251+n5VqrSUst/rBHSXtAnMCpvIMrO7DZvpJY6fz3vNYJv0RJ1c6tUkIktqj8Ql6W
 MBgP+vMDsr4CpnNhB9dTRUbiyr1l//xrz5zckyAZpn+4edzi5QAwHNeaUG4mcS5dWtQKeBRrL
 iPkZKF0Ou2X/8ibRxgqEVRPJ/8ASG0B6DnBcavm1cOJHRDiy7fKYiHkNTVWUNOAG1oQVvQS4s
 VI/BBBGC45EpTrNl96ixSM98ZrM9hsir+pEU8IBgmLonKMqj99+imtYP9pLwzmq/xFAF9FusE
 VDLM1MZtxQBBNQcZ8zfKL2xrtw1AfOMmR+xxrRZ5bP7MPsmhyfS6wTEhV9HAil0d1inBMOT35
 QRLkffuLyxoH2Q8p7/ZH10/uOuyl9ENXsghpJwSajMRj+0jet/hKypfPeiRI5FktMGGzgm3Y8
 y6s4OhfPR5nEEiuOQ+ixN9w2w7lf1mSPPHU4hgRB3CdPOpWhmy4atY2Wzv4Z7i8QzvwhkZXWD
 HUIUDAW+yTCoTKIIDQlwG734JY0ie81DRZgifMiD7GRAoebXEQ00Gl/ZDHPUPoevcNo4Ya+Nw
 VYew73RBe6WKwYdPaAp4CPjLjdktKxQE+KD3QpDnnpWXOlqPn3oJH9jBVJtOEgibAjcy2d7c7
 UQ9CPay3fL8DQcr2U1C8PZsUBemfxTlrtHVcHT4+xSLIQt2gfp3oaaaybNaNtL8alXHgO+fz+
 AoCbbx/WOI0mHUCkAMy5XZe3wOzBLpC1VkyH/jUkhEzROcHHNZNEsNykJ8qqxvxDYEr5TJpuz
 /uPQJ0Gl6MI+pPTcap7vsFwT2FnvGAlDllpjnG/5zhTUOAS2f7aqUrIU9+PfiZCKzAvggZMoG
 TZKRua8JGP3hly+hFtdKq7dsrW3xE7E/9ZliCVvO4U1MScXoPaEMFmBvj9uMmPpEkZvqYPPdF
 Lur8JngH37AOwRvRqsOcEtrGHtySBx1fpXQKyytFYThHq/uSTn8KPk463z93bcpfwJTkgx2cA
 dCBctT0DxztpoHRwFdRWHVfJ9Gw65dKu+SczdmGK7zkbG7oqdezzufKnkfF0cR5L10OQ2j2FM
 hE2OZkaxjFMQ/TEvzvvoO3iEDhFIR+MlASmc3ek5ta2P9PvDBso2Fd6ZL/ZAAURCe10wNZpm3
 E25g0xSPBTjW/eSSDIbEe75OKfaQPhiqm3hoJTds/7CiHQm/13NWPdQxfJ3uTayQF5XFuJrX8
 8+sofYRmQTNNMXBKHIgHLnzMKtuhj9TixuFXbdGOOceWuqzqiR05jrzEMm0sLEPBGKJ6nELxO
 rj38AlhRwMK+MCb2rSxvTDm7CiG5qjtv7GqMeS1cILce8tOkChvh0dY56GJhzwhu6+YtjmV8c
 9uJAvGCe9sWxOSaAzDc9bcW/4NhuFBhQMl3FnxQhFm+7K86x06GGip1V8p4sHUzp1avKLKFoJ
 O7z2s4njulBWXh/umXax2PinhuZdqGmnUE3Y8aWVxvxO/E7uL+4G9cKSqVDrmxx3mMa+PxMET
 9vljUTCGHsAeql5zRAjUsrH79DFfmyd/7Iosei4xUeE8EX3XFrh5/Kg5QYGeaISKDKWiAcxPu
 eaH3fm0Xzh2CcZYthgJxVFyg6hlcxyFE43Cfg1Dl/9Kxh60DTV1YDY1WoNLJbmPO5FIAjGKGH
 GHxPEn5eURyuwrYVFm2DKA40UJdOJvfFVVjHDRLctphWTCyCmtrcNNxDeuCacBHDpCq/o6CkO
 IhQyy+RG0aqlCz7NxFfkCt6PREc2knjmMjFR9u/hBl7n3A4u/aLorLKZffgZyjn7suLYQif+v
 /4UOt2RYMHhLuny3gxkA2HUKuN33G3kPU2LM71SabqYxf4csr6zaII6LEStAQvVuZfNWVanjR
 yhEY1CVFMZU5Zizds0+9qBUB+TykRvapG+EMQuGHKVG9PsTqUu3anveDHHibLxPVDqPt7jrhs
 uT5xsP97x86PVwX/EAVt03pcZ4sGrLtz/quzsAWL40hRNTZcnJEEs+kp85W6Ln4u0XJxbYC9q
 9jy6Sqi2mM93hs8JtpqnSrqGq1IHdleInUG5noPb84Lx2lOQIZ85PgLzwF1jhWvcpFh1V+eCP
 lXjRCLjX8zl7OKFdC0RxhlyaM8ws58dZOvpWkK06wx5J++p0Ast+P2bM9GTFiKiQN3LfxW3Fm
 b8mu6kJmmzD1u8E7zWZIgNcPY3tcjcoeaGCgH1XgYfQMbzfpoa16GEyZoSgRaJ7QSRazAa4+9
 529XtepixU3Hg2VnhijxAKOUXaPOxDCwnXK1QQTrUL8TZvGDcrRPck4GeYk3U6EXgvHolIF0D
 ylWB37EiIgZi+DeSO4nUFh6l+26bbdY43aa6EdGqVz9JGbvIVx4KLH6mhCibuUcYDs0o+kdtF
 9IJ4yJLRp7WrVr+Flbm6juirisW2Lk8mlJQAMNlAYpp1JtsPF+zTHKU6hB0HBAtkFBosCmGhL
 l9dnP4M2uAJT/kqploFS1s9SBfX2YCjyVswEhu++eV0S2Ol4a864eFxW+JaIELlI8K0hRXp2B
 NtP/9ac1c7jR5MwZ1gl631RvW0v8fr+kLFsAJP+67HQaPeZHWEixAuDfO6YrYgB95U5+g0Jel
 oJ+lDeh8S5v+WBBUiM+xU+L8JwNuIgGdkQxzUGWCNVmNE/ZEq0LdnwnQUcwtIallsPK7JjtTi
 1Zj6UXr9VOx1qOiIjTmi7+cpjSddj9PQBc90l/ngwpF5AyJQdLU2NKhD4TwCHtK+zBgygZWoo
 GYAOK4Frt2W/zRYjWV027UqJuyf7OTM9hFTdjGplDKgep5k8oH6NFc/pG4Qnty7eZuZlMZRdi
 DZvuWY73KcMyAGDAezqsSoEhGVcOpzRJVTXKUAlHoQec4d+aFj4vwO0n5i3iavrB9ZTYnR68y
 Xf5pqYTVrUbuHPin8Mxl78KB3jgaK1SHRVlKX5xBFdP4Tn8xCXi/tnUU6GN414JHjvH0kuhc5
 7pU1AWwQL2YOZExUwdVzgEz246pJoW1q0xVeTlHtXTd5K6kJ1fuYyN6rsRcer5dWRuHVpSf3U
 0J7uFcU3qCteu+AziyVoQj8h4VJtzW5TF/zjrIhRC01KsOw/yvtXPQQKA+AIGyQQnLAbjXjSh
 REVnSmEOeWdLLgI33hfoSqhbjl29gkDFe4KdP6wXau3YcOnBKbr4/ct0qFnZS7l18GKXm6uDO
 qKRz6aUzjt2+I69KuZftbWcDKGm7rtMAbjryZoYk6qAn61764AwPLTQ1jl982ZxUwrZpdaJJH
 eQBlge6BRJHzvYuln3A5heekX/V1SWUaHd5dtUIf7TxcU2ieg0az8z5D5jrpjeRy3v/pAu+ch
 jEwheabsoc0j8+KIENZ3x4DpAH7XLIxbVpdHwMQo6RIDCR0W3DnQmmSqb4k2tx5bbzJCmLnDk
 brwUiAUhL1PAIB21/PL1qr1TU+VOeWMzOLqUTF0XupctNW/Mkug/CchUfEVv+y0wapqMwvMQA
 s1oPCiT6gPOtP5LVp4RMKf1yuyCaqgCzV3v0En66/QFbAztdBtrOU2Fzo/8aY6twhiF7GGdCH
 jdJfI9Txin9JouGIWhave+8J6/KOlgX3HNuX6Gts7yxWuLZQKFV5N1q+qPvf1Lu5DSPP2i5/3
 YH5qKgHtxfLqxqH2BbOkkUTbw040lP7TJSVEiZFfkBFCjAeWtUtHa26jWJvTrDXlzMhWLD88+
 3zYe4NktqgaMj6s7q6qwzgcJQC/SRdfHeP3iaLxjgVgL+4cfaeucibcnI9d99uiLoDxrau11S
 bH9qsNI4M5+qx2XF0ohFMCrumHAHAR3qJBrDaWeWk9ruwlliK5d9wCqqc+PwHKp3r6v3pHekL
 BD49x6y+NmtaT9DclwQpQniakx5rSAKyZ3D+GrW30cQWZMjg/YuxvKa6EKRG/fLDxhNVddmKW
 75ZRB/sXPe+Be8TwqSKxkdSr2IP4LsWNgGIeoUnIPOoESkWdsDt2/RPbNNHzcTfMuSFhpTNia
 b/Ji/r5lEnS0mxjIOrmp4h6FaqnCy3jCJqgKCSqq88SC5t7aDU1/U+RivDZFptgxyyObgIFLx
 kHT3owk/m4vKWQ5ZtgHLPQov7GPV7Z3NGQ7BswXsYKRaooSnKhLXac/bdVxX4CM3QhXtJF8/+
 jVtivPS1cbNE7yYRE9OD2igt8ZjDEhh2vEGgNkxUmek3s5dWJLuqoC26qPm02A9C2s4XBEXUT
 YOMVQyUxTWnQNcCWAbHTjeszk1W0AkvvjO3UtG0dLQWSHrlFKF9LBVoKA1FevXBPbg8fjzA5H
 NTDnIGGnptyQpbOEfNRJyKT6ES1DlR8zgt9cOTAdKr+GpvuUERmAyemO5zLvZmasWeq9tnNQ9
 VkowmKhFVTFZpJ0kNo/kMczqTONUgVV/gmn6UM823sqX+AGpd2iH8K+4LVjlK0JqPapXR/hhm
 WO7tZgOADJs9v4FHHSyoRxnm9P8+NDhYC8+nE/JYMF0n0wsq78Y6mdCEl5H0/eLWAZRSXwORs
 PgbJYt0SdW1IZfW0ec9jD6ruISCiwUXxGfcYwbQDBrVdYEmfomcYwbYYJDzuWg0R34rwmUV73
 ai27r/J891ChpHqNSjbqZ7twZffb2FLGAS4bMOrlJPDyf9auzRoUHiW79M/cN/J8JSZZRN1mJ
 3sQwH3XvcI++K/VwNqSi4i30J2iln8wI3qz+BhPiyv5yLyzJIbRaxecF+Og4/CmIki1PEv27r
 P/k8CIxY=

On 1/24/26 10:56, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>=20
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
>=20
...
>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
...

>   arch/parisc/include/asm/pgtable.h         | 11 -----------
>   arch/parisc/mm/init.c                     |  6 ------

I reviewed and tested the patch on parisc, so:

Acked-by: Helge Deller <deller@gmx.de>   # parisc
Tested-by: Helge Deller <deller@gmx.de>  # parisc

Thanks!
Helge
