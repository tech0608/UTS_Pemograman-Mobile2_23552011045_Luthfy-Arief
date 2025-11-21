import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_cubit.dart';
import '../widgets/product_card.dart';
import '../models/product_model.dart';

class CartGridPage extends StatefulWidget {
  const CartGridPage({super.key});

  @override
  State<CartGridPage> createState() => _CartGridPageState();
}

class _CartGridPageState extends State<CartGridPage> {
  final List<ProductModel> products = [
    ProductModel(
      id: '1',
      name: 'Processor Intel i7-13700K',
      price: 6500000,
      image:
          'data:image/jpeg;base64,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',
    ),
    ProductModel(
      id: '2',
      name: 'GPU RTX 4070 Super',
      price: 9000000,
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx3GsNVIlOmC7IC94stMq3d_B6nBd95KAC1A&s',
    ),
    ProductModel(
      id: '3',
      name: 'Motherboard ASUS ROG',
      price: 3500000,
      image:
          'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExMWFRUXGBgXFxgYGBsYGhgXGh0aGBgeGxUaHSggGB4lHR0fITIiJSktLi4uGCA2ODMtNygtLisBCgoKDg0OGxAQGi0hHyItLysvKy0rLjEvMC0tKy0tMDAtLS8tLSstLS0vKy0tLS0tLS0uNzctLS8tKzcvKy0tL//AABEIAPcAzAMBIgACEQEDEQH/xAAcAAAABwEBAAAAAAAAAAAAAAAAAgMEBQYHAQj/xABGEAACAQIEAwUFBQUHAgUFAAABAhEAAwQSITEFQVEGEyJhcTKBkaGxBxQjQsFSYoLR8DNDU3Ki4fEVkhYkY7LCNHODs9L/xAAaAQEAAwEBAQAAAAAAAAAAAAAAAQIDBQQG/8QAKxEBAAICAAUCBQQDAAAAAAAAAAECAxESITFBUQTwE2FxkbGBocHRIkLh/9oADAMBAAIRAxEAPwDcaFChQChQpvj8alm21y4cqICzHoBQOKFUxPtO4aTHfwfO3cH1SrHw7i9q8ge26up2IP8AXwoJChXAZrtAKFChQChQpG9ikUEswUDUkkCB5k7UC1ConF9pMLaDl79sd2qtc8QJRX9ksBqAZ0NRON+0PAW8SMK94i6xUAFHy+ISh7wjKQZ0IMa0FsoVRLn2nYUBGy3AhvNYuMwC9xcGgF5ZlQx2MEaGYqT7MdsLeL7xcptXbTlLtpiCyn8pkaMrDUEaGgtFCkTiBEzRkvA7GgUoVyaGYUHaFFzjrXZoO0K5mFczigNQrgYV2gFChQoBVB+2PifdcPZQfFddLY9Jzt/pUj31fTWLfbnxGbuHsA+yrXWHmxyp8g/xoM5DBwD+br1qf7Lcbu2G/DaCNY/Kw5gj9d6rKiDPLn68jThL5Rgw3GtBvvZbthbxAyk5Lg3Qn6HmKt1u6DXl3EcUay6OJa1cIyMDD235rPPXbnv0q/cI+0x7SRcTvWWCCCFLLMNoRGYdNJg0GzlqqfbPt1awDIhtXbzuCwFsL4QIEszMIkzG+xrOeJdt8bcvF7eJy2g2iIiAEA6gllL689edVY8TvXnb7xda4+uUsQfBOwECACdvMUGi3ftNe8gy2Da/Ey3FZwbncspGe0VMZlaCQZ0HnIy3hmCvW7xvC6LucOr94WPfW3kMLgOuvMHUMOop9ehgRJHQjcHkRUdaxmVix0khLw/ZfTK48mH1HnQSGGvle78c5A+GGdfastP/AJe9r4hr4WEeW60jjMPae3bS4WK25t22YjNbXladgNV/ZPKejCCcRcCXIJUjLcj9nk2nNd53j0po99/EHBaB+IP8SydrgH7Q8v5UEz3YOckZndAr5iSLyLEB+riNH30B1hpecPxvdur2/ay5FbUF7Y0NpzvIgxzGUjdRMDgixHdFjIGa3ckSyflYHmRsf96bs7jNnjwx3yjpplvJpygHTp5UFixd7MZzswOozEkjyOu4284nnVm7G9sRh2GHuv4TJSeXlHSdqz5DcBgtmdBmgf31o/mXlmH1HmKh+018d8jW2zA2lhhpEkmfKg2Ti/2nXi2XDW1ADRLalwDBy9DGv9RUXxLt9jXZWVxagn8OBDAREkjMd+UDT3VkeI4lcaHLs0+2pJIzftRPPf1mmlt2hliQTz11A315xQan/wCPsbaJX72DKq2a53e5kELpBAKzp+0PffG+0CyFkPeZoOgteDPlmM06gEjY7eteb87ZMv5RB9Jqf7N8QdGRSM+ZhbC8ztly9DsJ6T5UG2J2+AVQ9m+7mC2V0VQwPLMcwHKNfrUba7S4p5LXygnRTlUwZ2hfERA05zVY7l+87gBWuMRsQpzFpURP70SRGm+9Obtl7TNafwlSDlkGQQTuJ3zHoQR5aBpvY7jD3La52LNrJP8AmIHyq4I2lZx2KG3+VT8QG/WtFtbCgUoUKFAW4dK81/aPxDvuJYhpkIRaX0QAN/rzV6K4tihatPcb2UVmPooJNeVLWe87MfabNcf1Msx+J+dE1rNp1BazSy4aRHLl1FI2akMMKIR4GjWH2bVT0fkR0/4qLs3GN5bbsUMhS3Q/lI98fGrbicALqxseR6VDXjbt3gmJSGKFCx2ZGMAzyPn60D7D3irZmGUO3d3l/YvjQMOiuI18186a9qD3Rt3V3zQRyI/4ET5+Qp2UjN3viyAWsR1eyZ7q8PNeZH73SoDtTeclLLyWt5vFyuAxkYdfCPjNA/ftHYGyufcPqTTHF9obZYMto7FXBIAdDyIA0IOx8z1qLwKiD4czNoJMAQV3+JpNsIfISJjXSBJGu2lBL2e1FxVChA0AgFiSY5AxGYxpPOmVvjV0ZcuUZCSmmwO6iSZXyPQdKSsYZtMoYzP5fjGtORw1tDI8SZx4gNNJ3Hn8jQIjGXoWCQFJZYWMpMzGmg122ol7EXi2Yu5MRMwY5jTlTixh1IGa4ok/tAyBM6zA2jXrSWIW34grZjMA+ISJ3HqNN59aBLuGI1O2wJ5eXSg2HEGWWeR6jzpO9bkAKhHUk0VcI3Sg5hySx5zv79Kk7OFHdu/OLrD+Equ/8VEwmDKpmOkn5Cefun3UtH/lwo6KZ/ztDfQUC9/Aotu2o9p7iKZ5AANH+pa7xDDZWtqOYnz1uMR8l+VKXyO9tA/4pc/wqikfFflSqoXvWQJJAXQA6mHY/WgNwnDPadmzkAkElpBgzs3WdZMHaOdWbD2pDXFJMgTJ2jTSTJ11nnqaacWvthckoQHZV18BOpk6iDGm3WnvCOI97hXvFQudioUSR4OeYMPXY0GldjreoHRUX/tVVP0q/WxoKo/Y5dz5mr0m1B2hQoUFG+2DiPdcNvDndy2R6OQG/wBGasK4AfxD0y6/ER84rR/t9xxP3ayBKgtdY9D7Fv4y/wAKynDuRqD/AFvVbxxVmG/psnwctckx0nayPgkBJyvqZ3X/AJoyW1mBIPQ0moUnvFuKA0EqYmeY3kUdGXrPlrH85rx1+JxaiZl9Nnj0fw7WvWtfHSZn5xrn+0/Q8FwIjMdlBY/wiT9KzXF3C5LMSWY6kmdfWr1xy9lw1z94Bf8AuIB+U1RtMyyJA1I8hvXufJSuWAuObIuRmu4cZXX/ABLDCSPMFRI81NVXjDKbpCPmtqAttuiRKqfSY91WjhtxrUHVjaUTH95hWMhhG5Q/Q9apt24GuNAADGIAgDpA8v0oJHhtpc0tIAtySNIZpI1+GnSi4RczFcxaWMNqCdfCeoqQwN0q10wrKWCMpEyiwpOUasPCdBrXcPhFFx1ti4UthczMpENGoMgRr1AoFcN2UuXnI79bQEKz3nIUA7CRJOvL/ij8S7Grhh+L37+2c9m3nQouUFhmykLqDmbL7Q001s3AOC3cW4w1q61ovLZ1JUqyI+UyNYloPkxq+YjsrgLGRr+OFlkBB/HQAzoZ7zVuQ19rKM01AyFuyS5QVwmKcx/i2UJ/hytHp51JcL7KW++tWntW0UhWcNfNy8peYVGtkW5ZVnVDGu420c47ganXHqYEeBoAERobSCPdXeGtwC/ira2b474AhUllW5ObTxrDHxHwg89qkZx2v4TZsvNhR3QKqw7wu6ltATKARmDDQn8u1M8Nw4GYWdPnU529sAjGBZVfvFpABAEpa759Ope6JPkByFcwKhLRZtlBLMdgABqfSgrfHrItoVI2tN89vm8e6o7E24t2gBpmtqQP8ub6mn/am9mFwDWRbAI2hjBHxtj40jih+NZHLM0+qKAKBteH4q/uref/ALmf+dTfY3i1rDY97t5iqJbcSFZoMWxsoJ2nWoW2kXepFq0nvcqD9TSnB79tLl27ccjQwMpO7MpGxgwB8d6Cf+0XtHaxj2BaLFULSXGTXc+1rtGum9NMHP8A07DqCQXvjUHXW5G9QfFLqFbTWdAQ5jQZTlUEa9CD5VO4a7FnAryF+x82VtfjQbh2PGk+Zq5iql2PTwCrcKAUVzpRqQxl0KhY6AAk+g3oMg7XD7xi8SzL+CjJhy0FoCqrscvMZnYb71nfHOCNhm01tnUHeAdteY6H+jp/ZjHXDbBNme+z4lszDM63ma4QixDFQwBBI2jmDReNcERVNxVz4Z9WgSbfoDrk12O3OsJnhnir+rsYormxVw5eU/6zGvtP9d/qymyaksNXOK8JNhiV8Vs8wZg9J9/6HXcuHYb1tWYmNw5mbDfDfgvHM17W3vBbTqxb3KI+rVX+Hg97KjMVGbLvmA9oesVJdpLk3QOSoNPMksflHwonAMKWl09tWzL5xoVn94SKlkmMSO7tnK4U21z2X3DWLsKyeZUsPTw1UOHKGvJO05j7vEfpVk7Suq2QirmRm72yxHso4IdPIhyunKR0qu8OH9qf3Co9XIQfWgfcLytdtZmKEksxgHcTtG+p5HSn+JxcYW+4xF1jdukD8PKjqCF1bLAlBsCOkb13hNw23Zma3aKoClxlklYZoCyM5lkPMgADY034ripwdi394zszFmt5QIkk6tE6MYjnNBYOyX3psFi3tFy9m2olMwuBHdA8EDWFDHQzHpRsLwtVWVtjbVgu/U5m3qY+zziTYPg2MxSqC7Xrdm3m0EtAkkdA5PqKi7y5MMyyrMEKjxMzZiIAHvNAfC2L7Kl3IBaMOT3kkLufCtsgNHUxVq7B8BOIv/eDlNqySZKw3ejVFB6iQSf56RbqVs+y4QACe6dRJI/xLhOYenwq4/ZldYWMWxfOgZCNIggHP74C0FA7WXc4B/xcTinnqO+WyunpZNM+N8N7ywczFFkANMAtMAETqJ01o3EXzHBDebFtz/muG5fb/wDYKR7Q8L7+2AGYEGQATlPqu0+dBCYuwQtlFEjvLaac4VX+rMa5imIu6crN24Dyli2vypzjW/FsKNg90x5wqyT7gPdTa283GB3W3YtbQIJUNptzoFMNaLYi7I17y2gHmhDH5KaJ2Ysh+9kSCoBHkTP60XBX9b10Ha9cf1EH5azXOGY61Ywrnu3a4Wify8jqZ058poEeMYdbTBVMoqXMpgEa3GTRjv8A1FWIWRmwCR+ZGOkSUTNJj0qscRxFpvECVVkgDJmM58zSSes/LlVnwOLW9isGyez4z5iEYQR1FBvPZRfw19Ks1V/sykItWCgFVf7R8UUwF8KSGuKLKRvnvEWljzlp91Wis/8AtJxIa9gcMXy95fa5uJPcoxUAHc52Qx5UCCcMW0A6W3uZI7u0rgIGjLmAMAbz5awKRtYh7NyXfvLl2C+HtWiVAiJDSQGjmx8QG3MOreKuRlEd4upTYXE6oxOh8jsdDoQ1M+J4NGti5YUKmc3LxRQt0kSYkxlYMTMxEe4428w6WC2/8cvSeW/xHy8xrW57m3FuFJkL2xnw7iSsSbZ1kqCJCzOZeUcuVH4jwc2X8MFTqDMwDsesHlOv63LA4/7uUJuIwvN4lzhss7vculiM22ggH3VTO2PbGxbuXbWGXMRAzaG3n1Dx1C+8Ezy3rXfWv2erNwcPw88+ZrbXjt/HiVM4i83Ljb+I/BfCPpUz2JiCp0YeL1Dag/pVWW8zDKdSxge+rRhHGHAZiA9mGUEx31hzDKOrKfoOtehwzftymR0APhOZgv7JYgtr0JWY6lqg+HKAkmPFcUa88oLR8StKdoeKHEXDcgKICqN4UbT56namF28DbRByLE+rQPoB8aCeF+5bF63byOtwMMxmVUyhkcmIXnyg0O1105rVs3bdwW0/u1gKYEz4jMgDp6UlwJQUjmZG4I3A23BAO3nTrifDlaCBlYzqOY3jTQnfTf6AL2OG3P8AomEt2bVxxcxbXG7tC+iBkBMTAJAPxpT/AKRiiQPu+KIP/ogjrrKjWh2J+018LaTC3LK91bULbuLMgic5uSeZ10GnMc60z/rmL7tbvd2xbbLlbNmkN7JASSZkbCgz1ey2NYyMKZ2zACy2/noatdnBXcFwjEm/IcreeCVJA7vKoJUkE6dedOuL9osXh8M2JvGxZtrIOdvFmBIygAHM0g6Cay+92g4hi0xT4vEizhriACyQjkJcPgPdrNxDlGYSBn2kA5gDHh11bmDTFXFKPYFuwCplbqAZF8B2dEVSSDBHIHdzdeVJB1ykj4SKiPvq31S3ZUphrYyqDueZk82Y6seug0Apxir4FszsBPwMn5A0EHfuTdOTX8C4wPmxJB+EGlcLreuNzN1bY/gg/Raa2Wi64XkLKfAqp+VFwrnJcu/v3HX4ET84oDYb/wCkOntJdJ9QygUqcZcTBhFsKVZ2l99nmGWNiBEzt7qQsP8A+Wy8stv/AFXDPyFO8Ti8R90tZMvdx4oHiAk6GTDCNNtfOaBDHcTOKMG0ttFtsRAnUaAjQbExHmamuxuBUXsO35itxtBAKkhRp6EfHnUddvZsO78yoJ11zMy5t/fVh7IWR95t6690d+csnL3R/QoN67PrCD0qZqL4IvgHpUpQcavPH214/vOIqgP9hbQaHVbjkudRscuSvQt46V5V7X44vjsS91WR2uMcrKVIQHKnLXwga7UF/wCxPaoYlVs4g/jpqj7F43IP7cbjZhPmBa7l1kuF7YEtErOlwDr+zcGsHZgI5eHB8PjlUhgSCIIImZG0HkavOI7fIMOSDnxAGVfCwU/vNoNt4G5iI5RMbaUyTXl1h37Ru0KW3KYZity5byvAy92pMkbTnbbXVRruRGXPY0p9duliWZizMSWJ3JOpJpF2pERCL3m88/cIxWZDoYI50ricfcuRnctlkCeU7/SiYlqTtpmMVKgs6e+nWGwJdZG+YDnz9B/U0/w2DUdDykj6jl+lStlgOXl/sf0NA0wdy4FXMuUKAs+kbnlvUscTYFtiWLaDKoEkmJ5bCY6dZp1w7H5WBhW3AzDMNdNVOhProeYqxcf4VaxqC6so/wCIRdZpVVBJAvXHaQunhRQzJn0lYSsq5Nzw2jUuh6j0UVxVzYbcVZ68tTE+JjcqsbtgFhFw+BWDZDLnXQEgdBvpJOtPbPaO9ZKBbuIRFtklQ4UAtlYQhbTmcw6gzzo3COHo8WHF21eAM23HikjMHQMAYK7rGo15AlveuZW7jESFH9ldXUqDMMp/Mh1lZ0MxBmdXPRXGb5Nu0HS6wDZz3l3OsGZjxnmZnlz3pxbw63lHh0K5gvIjcmNtIOp6U7uQsoVzrOmSSJJiQTykzOhEkFd6WwfEreGyq+GW6qysiAxUhvCwbTnPu050DG1CqF5AUTG4gFSIEHkBoNCP1qZXAXXw93Fh7Vm1N1woY6opMABVy8oGuuk6mqzi8eHgF8xgbmYhoA1+lA0wt8Z3bcF9fRVLfVaTwz/gGf2LkepKmkrTjI/Vi5gdSpgfA/OjXSDZCKdRE79YJ9KB1jIS2q8oQeuUljUzwNAbdpSJEaj0FV3G3s4zTp4yPcgH1qe4bqqL5dSPmNaAcdACFRM94oIDlSGZdD5iFGm2mlS/2dYVhiCWctCJAbUrm1InnqPlVRxmD7snxZg9xGlpJ0BME89G+tXv7O0nEXZ1I7oe4Z4+tBu/CB4R6VIUz4YPCPSnlAVxIqqdp+ytnFCLtpX3iRJHodx7qttcK0HnLtN9mN60S+GOdf8ADb2h/lfY+h+NUW8GQlLilGG6sCCPca9fYjBK3Ksq+17hdlbClkUsW0JAkAAs0HlsPjQYcb4pC7iKf4LhiMgZs2ZtQAQAB58/SkcYqlu7QCeZgaAVETta1Zr1MsMRLE9DE9TA+k9f1CxIgBVnTXT3+sa/KlXsOqBijZB+aI1O2tBMRESjdR4oncyY3qVSy4jJvpRxxFOvyPwpu+NItshRfGxbMTMTB0HI7a13h+CVgRJLaDyjQ789fpQPU4vbHP5GpbhXbNbDBgHaOY05RIaZVgNm3HxplguCgEDUkz03gxvStzCXbVorbRCCQxzEbaMZOnMD41W1It1b4PU5MEzwT1jUx2kXjXaVbrg21uqqksAxDspJkkXPaUE+LL7IJJETS2O7Zi6ipfsFtCc85Wk7MpiB57gxygRGX+NXybvgQZwEMLMASNDz3O9NOIcRe66d6FASBCgiRpO+8x6VZjadzs7w3aPJGS20jeWnTbbLH6RoZpS92nLkxYGoGmaQNpjSYJ+HXnTy/bwt+5ms22swB4SBlbQyYVi0yfSKTucMERmJ0PUgCZOsALv8j5UQjv8Aql90FnxizJPdgyskzMEEbmabY6xctnPIIJHigaEbctDHSptuDWwgiS/TXaDM6x/sB50ZrOgOQsDoxOYjWdCZ/lsaCqpiGGx69Oe+tKKXykSQMoMdVmN/Wpg8MvM2VEZjAjKJMCBsP1pve4c/hQoyEAiOpAk6RpzoIwZgJIIB57A/0KtXDMSDlI9PjpTXA466i93ktzoNVOYFYMhswgwvLzrnCsMQRtpBOYgCAfdPuoHPGrTiCoLZZJEkHWORHl86t/2Tku9xypWXAg+Sjnz1NROHKKWDgDWRlAYHeYmfI9Nx63D7OLYLMVEAuYEzyHPn60GxYAeGnNIYMeGl6AUKFCg4axX7bsfmv2rG4W2WYf8A3Gj6J862pq84fa194HEbhNtvHAsnTKUVVBMg8iSSDtNExEzOoUninEMo7u3odiR+UdB51Mm0hsWbdu2iOn9o0eO5KySWyiAG0iTsKiks2rRVzLsJB00ZjMxJ2HzpyvGUA9hwZ0Om0f5utRE7hN6zW2pFx1wP+E2IyhSPCEBkgxqc4mOlcx9q3cuS+I1UFAFtgARJ/wASYkmi2eMuD4bNto2JDAz1IDx8IpVeK3eVi1/r+fjqVQs28IB4mZz1gDl6n0p+mLwo9nOOugP6UyHErv8AgWdPJ/8A+6OuOv8A+BZ/7W8v39NqB8eJWNx3m3If7f1FJ/f7G34nX37EgZOcT76a/e8RysWfg3l+/wCVEfiF8GDZsAwPyv8ALx/1rQOO/skHuw4KhmGYabaj2RGsfDTkalcBjbXdOn3VO8FtyLznM3MyigmCBtpyqu4jEX3UqBatgrByBhI03knpUniONYxsOcMow6WigQhEyswAA1aNT160EJav92wRjtlKt+zmAb36GrDgcel9BZvEWnHhS8PCsn8l2OXRxqvOREV1+FXe8W45VhmTNBJIXQTry5VZ+McBlRftAEHcAEifKIkxrlB+kCk3iJiJenF6W+THbJXnw9u5F7D2i1u+WUjZpJA5iQJlSDOYcoImasHCuEqyBVV711lJdTeFuF/KbKKD35I2aSog5lG9VQ8XzWe5uQQP7NifFb11Abmhk6HSdRBnMMDjig7ppa2Z2PiQnQsv6rsee8i7zLFbs3+H3GZAGVvA48MjZwpys3dXIg5ZOm2YVVeJ8UxDXWuqFChmYW94VjproWgGJ8q0HhHEvvKrg2W0iNbyLcUnxEHwZbeWGI18D+IakMtQHG+z+TxJcW5ADSvIExm0JUrOmdGYA6NlJoKbZxN3PLg/iHMdIERG0eQHuqdwsrMfmEbxv6elGw9wHwOIM/E8yWM6xy/ord0VI5ieWvyFAnfualm3Jk/8mtA+y0hrasNmJPziszxWKRgYYGQY1rU/srt/gp7/AKmg1rDDw0rSdnYUpQChQoUHG2rDftVxOfHMi691ZUR+85LH/SRW43DpXm/tRjRdxeLumTmvOq+lr8MenhWfdVbeG2DlabeImff6qnxSy0rp11Gon3c6SSyCKm2e1BDW3Op2uIOfTutKY3sIyyRlOgMSZEwYJjfUa/SrMUfcsFYI/r3VIYNg3kf6+VRtziDA5Sm/MtA+JED1rn3koAQFPkp1E+6gsPdil0tiq6vaHrbM+v8AtSqdov8A0m+P+1BaLdsUbG8MW4sbHken9dKrtrtMCwHdmfUb/CnP/ioCQbTmNCQf1oGt601tirCD8iOoPSjpdoYrtNh7iZHtXJ3VpBZT7+XUfrrUeMUQoYo8EkTA3G/OglYJdWzQBBgcyMw9PzGR5VL4PiDWQQCe6b21G4Eycp10+npVXt4/oj/D/enNni408L6+W5+O9VtWLRqW2DPfDfjpPNPcc4ELqfeLBGu/k28EnnznY89daqiMw8Lbg89CCN9/+aluF8e7px3YfK8gqRAHWDy9OVTPE+E28UjXrWRSD7Mkwo2zTry33HmAYyi0454bdPLo5MFPV1nLh5W71/r3z76nrzst2isqFs4hCbZKoSrFVys0l3QAhnUGVeC3hA0iQXE4Zr13LbxAuzqpebQa4QBlAYaOygHO2XP5mnHDuz9jGYdUw82sfYX8Wy5A74anMp256EabA8mqNt9oithrD2lYx3ctEAA81AliNvajQaaa7uRMa5SiOM3CLbhgVuKQCDoykMJBB+h28tZU4HxjOuRvaAEdNPp7tacdo+KrdwxDoTcGRVuk+PKD7Dn+8AjwsfEBoZ0qv9ng2clRJAO/p5UE3iMKoUmBMaE61sP2ZWYs2x+6P51jt/EOPaTTSTIHPpNbf2AtQi+QFBoNraj0VBpRqAUKFCgY8bxgs2Ll07W0dz6KC36V5hR4RMx8RgnzYmTykmGrdvtfx/dcMxHVwtr/AL2Ct/pmsUxeDVrPfW7qOiFEcrIysZy6MuYkiRCiNNarbrDamuC0d/c/wb/9PYDV7ZiZhxOmvONf+dpNGvYgMSQeZAEbDl5THv06Uk2UKGS5IZdPDqTz2G06T5VHY21cuKAptwGk5riq0j/MRG+/nUxO2dqzWdSkxge9V9VUqheSBrlEwB+ZoBgeVL8K7NNcUPcdbdpsoVgyuzs0woUHQ6Gc2o5AwRUPiLN5n0W2EgAr31qZkmdX3n6UocHfA8EayDlvWxM8jD8/hUqovi6qt/wHMFJUMIIbKYBmNeQnmAKsH/SSqIbiZc65hMGR101A8qhrXA8SWE2gRPJ0Pps0xVr+63yqBlc5QFG7D0A5elBDnhClpjcjoPnoBTu/gkTDuwUyQANNdWj6ec0/TA3CY7q509ht/h1o3GbDrYEqwlkLeEkKAOenhE9eZFBVTgEdj10MEQddefnp7qkb/DiwQ21IAyp4QTAEAsRsZk/A0/w3B7uIE2LbOUJlgVAUnQAlmEzGo/2qLx+Na0722TxoSpGU6sNN5PMRpQN79lrbQylTuJESOo8qEhuWvMdfMdDSPGcUBlyIwJ1LEddhPXQ/GuWmzKHAMenMb6/D40Dj5z8z+jfWnWExZRgd9Zg7GORHWmivm9fk3+9AH+Rn6N/P+hExExqWmLNfFeL0nUwt3cLiVF2y7W8Rb1GXRwdSSmWNOqeZjU+KqYjBFmiAl4a5FHgvDbNaAgSeaaT+UA+ClMJi2ttmUwR8vI/zqysLWOSG0vb66ZjoJU/t/AED3jDc4559HWtXH6+vFXVckdY8/wDPn278ucUjGt+CdZ8S/Rz+lO+yNoZmP7h+bCjdp0dEyXRLl/7TWXCgjxD9oZoJ3POdyhwTDB1aQQIXcfMe8VvE75w496Wpaa2jUwl8eJgHWWH863DsMngX0rBUwx7xAGYyw00gD0+Xvr0F2MtwgqVVwFdoChQChQrhoM/+1PBJiRZw1xnVSWuEpAMoAgGoIjxk7cqqV/sRhbzF2cgmJOS3yGUSABOn0qQ+0DtAEx5twpC2rYIYbElm0MyJBFRWJ7SBbNxgqghHIidwCRu2nT+poKEt4d2mSQAWRDO6K0KeZE+sadKZ3cNaUBrjXbcnUZGAE66FX6RyHLSKNw5xatLmkc9yI31EHoRz3Gxpxi8aHAXOzAamdfF7M7anKqid9AOQqIjTTJfjnfyiPtGjTNYaW+8EST+W6AJn9mQBqa6lqy2gxY169959Uk/Pf1pLiVl2RVTLC68wZ1ESRFPM9kLYHdZGVTnfweJzGWdSSN9YBkjlUsyP3S3p/wCbTUcyRy87f9SKUTAA6LirRnYd5bHXkVqN4gHdy4SF2AXUEjSSPPyHKpC3w1AFJRTI1EN0BMz68qA54fcBj7xa2n+1tadJmIrq4O6hVmuplkTDIZH+UNMb6xSQ4QjtAUCemnr5Chc4DbAaTqNoO+o1jmD5bcwKCY7M8FxN+339q9kt5mzS+QEjUkhRI3+VQ+JxCsQ4b89wsQZgHKFGZiZmGPz0ruF4ZZSe8Fw5k/CysNGPMhhqN9BBpHE4AIjQrGRH8WhPIgGIE6aE9aCWwPE82Eu2wigvORmKyfENAI1Iy89NKZ3QAJcMdDm2+uhEHpTHh9kIp0l9I6CNiRGuvnVhAygApBAEnPI1knZOYB+E0FfaJ0kDlOhjlNKq8+vXqOhqQxS+JlFlsxGrTKawQNuWnx8xUPfVgYC6jkwj4GdaBef66eR6j+vVXDX2RgykgjXTl6dRTQpf08A2mZG3xM6Tp5Utdw95UR8qnNqqgtmGkmRG1RMb5StW1qTFqzqYE7UYnOLf8RPqYnXntXezuIAtsDJMgem8UzxzXXGQ2ysENHuPI1KcDwoW0SwEkmZHKBp8ZqK1isahp6jPfPknJfrOv2jR5wy+rX7YB/MOR6g16E7Jp4BXnzhVucVajkwP+/y+deiuzC+BasxWEUKFCgFEunSj004riRbtPcOyKzH0UE0HmftniPvHE8UwZgO9ZZXktod3y5eH5014PwO5ina0MRkTKxLXG/KsT4Zk7io3DtcdswzF3PiykyWczGm8mrljVsBrxu8MvIlmwIHIXCNXuEGNQNNSTB0qtraTWNqe6qyKltwYJBaNDrA93P31Gd6wQuqgrsZWNDoZEnSaUwxQL4w4DTorZeg3yke6KXKYbJGa8qkn81thIg9FzenpUxGk2txTswtYkH+7T4AfpR7mInwZSozAkiTtI6ec08w9nDj++fl/drpAOkC7rv8AL1p4iWT/AHw99th9JqVUfwd3GysRMyASJ/nt/Rq28N4mqW7ytaDtcTKpaALftAnYxupkRqgGxIqGS1b5XrXwuD/4VJYe6CCpu2tSCPxAPZnKGDRzO/ltQN1JkErlnNrI9kAHQj3/ACp6LZyAlkJE+CZbTfw5I5Sdf905YiPwWJzyRetmc0dTpSYxBW4VJm65NsJo054gi4G31jLHvoHOJwmEGCDy5xJc51E+EAsBIyxr4PEDMmI00jbatk1fQ7ANvPl6CnvGODYiwA11YDHKIYNJ1PLX41HNcUsBJVfCCSDIH5jAJnmYFBLdpeG4azcVcPfF4ZZJDKw3IBBTQSAGynUZgNYNG7NcFGLd818WRaXOWIBOUkKxhmUZVBzMZ0A0BqL4ndt96y2rpuWxBV4ZcwIBMKxJEHTXpXbtoAKQSWJMKQDoNjO3/NAjdxpLNLak+0BGvLQjTy9OoppjLjkliCfZlj7IMRIA12+lP8QiIw1BOUSddCZkQQOn/FR1y7qTy5zpHuk/pQPMJndDCZgDqygkRrrIEDY7nkamL6/2a7xbadefgTf+L5014Lx97Fm7Zshct5cjEgkwQw8MER7ROs60hicZLjumtscpkTM+JW0ImD4RQR1m74iD8PnprodZ8/LktcxLRKgka7KNeW+YQfdTPBguYVdyYVdfSI391LBqCW7IOXxaSIME/CenrXo/s6sIPSvPHYRZxfnl/l/OvRnA18A9KCVoUKFAKp32s47uuF4o/tJ3Q/8AyEW/oxq41SftV4LfxeEFuwVzLdS4VfQOqhvDPLUg/wAMc6DE+z13K4s51tDMC1+R4ApDTBG8iJJ0gfs6vONXrjYbEOOJLcS9eyhCq5nywpJI9ldNABEAdaPwvhOLwt83LuCW8CCCuZSsnYwzGY6R+lMO0Nl7thUHDmtupZmdVku5zayuoGswf5VleJmei9ZjSHs4SLSPCuX2BzadSCrDn67ba01fEjZrB0kStxh9QRTtXv2xAS8mpMZTGu3TSluH48uzreIKhNcw1GoEgqQatu0Na0xX5RM7+kfncfhHp3bT+Bc2nS4jep1tjSiFMOfy3QT+5bYT7mH0qw4q1hVFx0xLs+UwrWWOcnWMwUBZH5p3qFu3PzeLWZ032577gVd5yP3Wx+248zZYf+1jRTh7PLEKPUXh/wDEgfGlPvEtA0npm9OfWuLidQoI105dDyjT/eg4uBU+zibR9bmX/wB6ilOH4Jrt63Yt3BnJaCGGUEa+0B5aQOdJ3zEEANqRt7+Q11kU2fEBde7WfIEHb0G4/qKC0cYwN3C90mKuh8xLD8RmMKCTvGWdACOlQWFxS98iGAMmQ6nUwRuGP5dJGmnTSm2FYPBkyDMGTA8pPWum1kvZzrJZvZzAyxXVZHP60EhfGe5CHNsJE+0NJGYT5R+lGdGQgNod+m4BHxBB99NMFxAW3DsOc7EAhpB9xBIpzjOKd6S2hEaADbn/ADP8VA+w16LNy4TqmXJMe0xAbQgzp191IcdwiI1sW76X5tI5dFAAZpm2YJkrAEnWeQpK7ZyghwubXLDKRoYMlSdJGnWdKcNlNxRZVdATHtSTyhhBImgiZK7+/wAv6/rykWwqEgiM2XcXIM6Tqpnk3h3GnXQxuXC5/DtyFykBRDQZLROpkbjpypL7wC5c5bcj2FJ8JgruBvOsee4oBw0d1cXKQCOZ1EkxoJU+6ZpjdB/KV+fy1H0qUuNLh2PMx4o11I3aQNRzGs9K7wOxac/iEL5M2Ub6+LMDpp10LHlNBLfZlbY4li3JR8yP5V6M4QPCPSsK+zmwv3m9kMqCoB6iW8zW88NHhFA8oUKFAKTu25pShQRV7hCtyFNX4Ah5Cp+hQVi52bT9mm17sqh3WauFcigoF/sLYO9pD/CP5VH3fs6scrSj0lfpWn5RXCg6UGQX/swsH8rD+N/1NM8V9mCHZnHpl/Va2o2h0opw4oMDxf2VT/eP7wD9IqNxH2U3OV3/AER85r0WcIvSiHAr0oPNSfZti7ezIf8AuH6Gm2L7E47SFUwI9qfPnHMV6aPDV6Um/CVPKg8sYnsfjdfwfgVPLoDpSScExSjXDsCP3Gg7blf59a9TPwNOgpB+z6dKDy/cw94RKZRzlSPrqRpzPWmL3mB2Gm3I7ev9a16mfs0nSmt7snbO6g+6g80W8dcWGWQ37QZgRPmGn50azimJJMyNDoTp09r9Bua9DYjsJYbe0h9UU/pTF/s5w/Kyg9Fj6UGGpxFgDLkiZiOYgcwRtPpNdTGAgzl0AiDEklSdgJ/N8dNtdlvfZpYP5CPRnHymml/7MrZ2zD0P8waCF+yYSztvLxPWJGn9c63fAjw1RuyPZFcLooO8kncnz/kKv1hIFApQoUKAUKFCgFChQoBQoUKAUKFCgFChQoBQoUKAUKFCgFChQoBXIoUKAZa5kFChQc7sdKKbA6UKFAZbQFHoUKAUKFCg/9k=',
    ),
    ProductModel(
      id: '4',
      name: 'RAM Corsair 32GB DDR5',
      price: 4200000,
      image: 'https://images.unsplash.com/photo-1562976540-1502c2145186?w=500',
    ),
    ProductModel(
      id: '5',
      name: 'SSD Samsung 1TB NVMe',
      price: 1800000,
      image:
          'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=500',
    ),
    ProductModel(
      id: '6',
      name: 'Power Supply 750W',
      price: 1500000,
      image:
          'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=500',
    ),
  ];

  String filterType = 'all'; // all, with_quantity, no_quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid View'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          final filteredProducts = _getFilteredProducts(cartState);
          final totalItems = context.read<CartCubit>().getTotalItems();
          final totalPrice = context.read<CartCubit>().getTotalPrice();

          return Column(
            children: [
              // Filter Controls Section (Section C Bonus Features)
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Filter Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildFilterButton(
                            'all',
                            'Semua\\nProduk',
                            Icons.grid_view,
                            cartState,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildFilterButton(
                            'with_quantity',
                            'Ada di\\nKeranjang',
                            Icons.shopping_cart,
                            cartState,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildFilterButton(
                            'no_quantity',
                            'Kosong\\nKeranjang',
                            Icons.shopping_cart_outlined,
                            cartState,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Special Action Buttons Row (Section C Main Features)
                    Row(
                      children: [
                        Expanded(
                          child: _buildSpecialButton(
                            '×2',
                            'Gandakan\\nSemua',
                            Colors.green,
                            () => _doubleAllQuantities(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSpecialButton(
                            '+1',
                            'Tambah\\nSemua',
                            Colors.blue,
                            () => _addAllToCart(context),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSpecialButton(
                            '↺',
                            'Reset\\nKeranjang',
                            Colors.red,
                            () => _resetCart(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Real-time Total Info Bar
              if (totalItems > 0)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '📦 Total: $totalItems item${totalItems > 1 ? 's' : ''}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '💰 Rp ${_formatPrice(totalPrice)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),

              // Products Grid with Dynamic Content
              Expanded(
                child: filteredProducts.isEmpty
                    ? _buildEmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.all(12.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                            ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: filteredProducts[index]);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<ProductModel> _getFilteredProducts(CartState cartState) {
    switch (filterType) {
      case 'with_quantity':
        return products
            .where(
              (product) =>
                  cartState.cartItems.containsKey(product.id) &&
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) > 0,
            )
            .toList();
      case 'no_quantity':
        return products
            .where(
              (product) =>
                  !cartState.cartItems.containsKey(product.id) ||
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) == 0,
            )
            .toList();
      default:
        return products;
    }
  }

  Widget _buildFilterButton(
    String type,
    String label,
    IconData icon,
    CartState cartState,
  ) {
    final isSelected = filterType == type;
    int count = 0;

    switch (type) {
      case 'with_quantity':
        count = products
            .where(
              (product) =>
                  cartState.cartItems.containsKey(product.id) &&
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) > 0,
            )
            .length;
        break;
      case 'no_quantity':
        count = products
            .where(
              (product) =>
                  !cartState.cartItems.containsKey(product.id) ||
                  (cartState.cartItems[product.id]?['quantity'] ?? 0) == 0,
            )
            .length;
        break;
      default:
        count = products.length;
    }

    return ElevatedButton(
      onPressed: () {
        setState(() {
          filterType = type;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        elevation: isSelected ? 3 : 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.8)
                  : Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialButton(
    String symbol,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        side: BorderSide(color: color.withOpacity(0.4), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            symbol,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    IconData icon;
    String message;
    String subMessage;

    switch (filterType) {
      case 'with_quantity':
        icon = Icons.shopping_cart_outlined;
        message = 'Keranjang Kosong';
        subMessage = 'Tidak ada produk di keranjang';
        break;
      case 'no_quantity':
        icon = Icons.add_shopping_cart;
        message = 'Semua Sudah di Keranjang';
        subMessage = 'Semua produk sudah ditambahkan';
        break;
      default:
        icon = Icons.grid_view;
        message = 'Tidak Ada Produk';
        subMessage = 'Produk belum tersedia';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.withOpacity(0.7)),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subMessage,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Section C Bonus Feature Methods
  void _doubleAllQuantities(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final currentCart = cartCubit.state;
    int affectedProducts = 0;

    // Double quantity for each item already in cart
    for (final product in products) {
      if (currentCart.cartItems.containsKey(product.id)) {
        final currentQuantity =
            currentCart.cartItems[product.id]?['quantity'] ?? 0;
        if (currentQuantity > 0) {
          cartCubit.updateQuantity(product, currentQuantity * 2);
          affectedProducts++;
        }
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          affectedProducts > 0
              ? '🔥 $affectedProducts produk dikali dua!'
              : '⚠️ Tidak ada produk untuk digandakan',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: affectedProducts > 0 ? Colors.green : Colors.orange,
      ),
    );
  }

  void _addAllToCart(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    // Add 1 quantity for each product
    for (final product in products) {
      cartCubit.addToCart(product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Semua ${products.length} produk ditambahkan ke keranjang!',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _resetCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🗑️ Konfirmasi Reset'),
          content: const Text(
            'Apakah Anda yakin ingin mengosongkan seluruh keranjang belanja?',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final cartCubit = context.read<CartCubit>();
                cartCubit.clearCart();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🗑️ Keranjang berhasil dikosongkan!'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}
